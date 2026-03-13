import 'package:conet_app/features/onboarding/view_model/onboarding_service_provider.dart';
import 'package:conet_app/common/gradient_elevated_button.dart';
import 'package:conet_app/common/selectable_chip.dart';
import 'package:conet_app/util/constant/colors.dart';
import 'package:conet_app/util/constant/text_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class SkillsScreen extends ConsumerStatefulWidget {
  final List<String> interests;

  const SkillsScreen({super.key, required this.interests});

  @override
  ConsumerState<SkillsScreen> createState() => _SkillsScreenState();
}

class _SkillsScreenState extends ConsumerState<SkillsScreen> {
  List<String> selectedSkills = [];

  void toggle(String id) {
    setState(() {
      if (selectedSkills.contains(id)) {
        selectedSkills.remove(id);
      } else {
        selectedSkills.add(id);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final skills = ref.watch(skillsProvider);

    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 30),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "STEP 2 OF 3",
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  color: AppColors.chipSelectColor,
                ),
              ),

              const SizedBox(height: 10),

              Text(
                AppTexts.onboardingTitle2,
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              const SizedBox(height: 10),
              Text(
                AppTexts.onboardingSubTitle2,
                style: Theme.of(context).textTheme.bodyLarge,
              ),

              const SizedBox(height: 20),

              Expanded(
                child: skills.when(
                  data: (data) {
                    return Wrap(
                      spacing: 10,
                      runSpacing: 10,
                      children: data.map((skill) {
                        return SelectableChip(
                          label: skill.name,
                          selected: selectedSkills.contains(skill.id),
                          onTap: () => toggle(skill.id),
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
                onPressed: () {
                  context.pushNamed(
                    'learn',
                    extra: {
                      "interests": widget.interests,
                      "skills": selectedSkills,
                    },
                  );
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
