import 'package:conet_app/features/onboarding/data/onboarding_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final onboardingServiceProvider = Provider((ref) => OnboardingService());

final skillsProvider = FutureProvider((ref) {
  return ref.read(onboardingServiceProvider).getSkills();
});

final interestProvider = FutureProvider((ref) {
  return ref.read(onboardingServiceProvider).getInterests();
});
