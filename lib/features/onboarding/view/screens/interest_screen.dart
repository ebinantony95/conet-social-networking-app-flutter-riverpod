import 'package:conet_app/features/onboarding/view_model/onboarding_service_provider.dart';
import 'package:conet_app/common/gradient_elevated_button.dart';
import 'package:conet_app/common/selectable_chip.dart';
import 'package:conet_app/util/constant/colors.dart';
import 'package:conet_app/util/constant/text_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class InterestScreen extends ConsumerStatefulWidget {
  const InterestScreen({super.key});

  @override
  ConsumerState<InterestScreen> createState() => _InterestScreenState();
}

class _InterestScreenState extends ConsumerState<InterestScreen> {
  List<String> selected = [];

  void toggle(String id) {
    setState(() {
      if (selected.contains(id)) {
        selected.remove(id);
      } else {
        selected.add(id);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final interests = ref.watch(interestProvider);

    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 40),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'STEP 1 OF 3',
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  color: AppColors.chipSelectColor,
                ),
              ),

              const SizedBox(height: 10),

              Text(
                AppTexts.onboardingTitle1,
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              const SizedBox(height: 10),
              Text(
                AppTexts.onboardingSubTitle1,
                style: Theme.of(context).textTheme.bodyLarge,
              ),

              const SizedBox(height: 20),

              Expanded(
                child: interests.when(
                  data: (data) {
                    return Wrap(
                      spacing: 10,
                      runSpacing: 10,
                      children: data.map((interest) {
                        return SelectableChip(
                          label: interest.name,
                          selected: selected.contains(interest.id),
                          onTap: () => toggle(interest.id),
                        );
                      }).toList(),
                    );
                  },
                  loading: () =>
                      const Center(child: CircularProgressIndicator()),
                  error: (e, _) => Center(child: Text(e.toString())),
                ),
              ),

              GradientElevatedButton(
                onPressed: selected.isEmpty
                    ? null
                    : () {
                        context.pushNamed('skill', extra: selected);
                      },
                height: 65,
                borderRadius: 20,
                child: Text(
                  AppTexts.continuelet,
                  style: Theme.of(
                    context,
                  ).textTheme.titleLarge!.copyWith(color: Colors.white),
                ),
              ),
              SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
