import 'package:conet_app/shared/button/gradient_elevated_button.dart';
import 'package:conet_app/util/constant/images.dart';
import 'package:conet_app/util/constant/sizes.dart';
import 'package:conet_app/util/constant/test_strings.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Onboarding extends StatelessWidget {
  const Onboarding({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppSize.defaultPadding),
          child: Column(
            children: [
              Spacer(),
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
                  onPressed: () {
                    context.pushNamed('login');
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
              Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
