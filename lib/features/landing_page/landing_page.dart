import 'package:conet_app/common/gradient_elevated_button.dart';
import 'package:conet_app/features/landing_page/landing_provider.dart';
import 'package:conet_app/util/constant/images.dart';
import 'package:conet_app/util/constant/sizes.dart';
import 'package:conet_app/util/constant/text_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class LandingPage extends ConsumerWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(AppSize.defaultPadding),
              child: Column(
                children: [
                  // illustration
                  Image.asset(Appimages.onboardingImg),

                  SizedBox(height: AppSize.spaceBWfields),
                  //title
                  Text(
                    textAlign: TextAlign.center,
                    AppTexts.onboardingTitle0,
                    style: Theme.of(context).textTheme.headlineLarge,
                  ),
                  SizedBox(height: AppSize.spaceBWfields),

                  //subtitle
                  Text(
                    textAlign: TextAlign.center,
                    AppTexts.onboardingSubTitle0,
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  SizedBox(height: AppSize.spaceBWButton),

                  // button
                  SizedBox(
                    width: 300,
                    child: GradientElevatedButton(
                      // shared preference
                      onPressed: () async {
                        await ref.read(landingProvider).completeOnboarding();
                        context.go("/login");
                      },
                      height: 65,
                      borderRadius: 20,
                      child: Text(
                        AppTexts.getStartedlet,
                        style: Theme.of(
                          context,
                        ).textTheme.titleLarge!.copyWith(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
