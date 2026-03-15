import 'package:conet_app/features/landing_page/landing_page_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final landingProvider = Provider<LandingPageService>((ref) {
  return LandingPageService();
});

final landingStatusProvider = FutureProvider<bool>((ref) async {
  return ref.read(landingProvider).hasCompletedlanding();
});
