import 'package:conet_app/features/authentication/view/screens/create_account.dart';
import 'package:conet_app/features/authentication/view/screens/login.dart';
import 'package:conet_app/features/home/home_page.dart';
import 'package:conet_app/features/begining_page/onboarding.dart';
import 'package:conet_app/features/onboarding/view/screens/interest_screen.dart';
import 'package:conet_app/features/onboarding/view/screens/learning_screen.dart';
import 'package:conet_app/features/onboarding/view/screens/skill_screen.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: "/onboarding",

    routes: [
      GoRoute(
        path: "/onboarding",
        name: "onboarding",
        builder: (context, state) => const Onboarding(),
      ),

      GoRoute(
        path: "/login",
        name: "login",
        builder: (context, state) => const LoginScreen(),
      ),

      GoRoute(
        path: "/createAcc",
        name: "createAcc",
        builder: (context, state) => const CreateAccount(),
      ),

      GoRoute(
        path: "/home",
        name: "home",
        builder: (context, state) => const HomePage(),
      ),

      GoRoute(
        path: "/interest",
        name: "interest",
        builder: (context, state) => const InterestScreen(),
      ),

      GoRoute(
        path: "/skill",
        name: "skill",
        builder: (context, state) {
          final interests = state.extra as List<String>? ?? [];
          return SkillsScreen(interests: interests);
        },
      ),

      GoRoute(
        path: "/learn",
        name: "learn",
        builder: (context, state) {
          final data = state.extra as Map<String, dynamic>? ?? {};
          final interests = data["interests"] as List<String>? ?? [];
          final skills = data["skills"] as List<String>? ?? [];

          return LearningScreen(interests: interests, skills: skills);
        },
      ),
    ],
  );
});
