import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:conet_app/features/onboarding/view_model/onboarding_service_provider.dart';
import 'package:conet_app/common/gradient_elevated_button.dart';
import 'package:conet_app/common/selectable_chip.dart';
import 'package:conet_app/util/constant/colors.dart';
import 'package:conet_app/util/constant/text_strings.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class LearningScreen extends ConsumerStatefulWidget {
  final List<String> interests;
  final List<String> skills;

  const LearningScreen({
    super.key,
    required this.interests,
    required this.skills,
  });

  @override
  ConsumerState<LearningScreen> createState() => _LearningScreenState();
}

class _LearningScreenState extends ConsumerState<LearningScreen> {
  List<String> selectedLearning = [];

  void toggle(String id) {
    setState(() {
      if (selectedLearning.contains(id)) {
        selectedLearning.remove(id);
      } else {
        selectedLearning.add(id);
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
                "STEP 3 OF 3",
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  color: AppColors.chipSelectColor,
                ),
              ),

              const SizedBox(height: 10),

              Text(
                AppTexts.onboardingTitle3,
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              const SizedBox(height: 10),

              Text(
                AppTexts.onboardingSubTitle3,
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
                          selected: selectedLearning.contains(skill.id),
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
                onPressed: () async {
                  final uid = FirebaseAuth.instance.currentUser!.uid;

                  await FirebaseFirestore.instance
                      .collection("users")
                      .doc(uid)
                      .set({
                        "interests": widget.interests,
                        "skills": widget.skills,
                        "learning": selectedLearning,
                        "profileCompleted": true,
                      }, SetOptions(merge: true));

                  context.goNamed('home');
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
