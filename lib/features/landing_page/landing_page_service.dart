import 'package:shared_preferences/shared_preferences.dart';

const _onboardingKey = 'hasCompletedOnboarding';

//write operation->. Saves a boolean:true

class LandingPageService {
  Future<void> completeOnboarding() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_onboardingKey, true);
  }
  //read operation-> check there storage value(key exist ,true)

  Future<bool> hasCompletedlanding() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_onboardingKey) ?? false;
  }
}
