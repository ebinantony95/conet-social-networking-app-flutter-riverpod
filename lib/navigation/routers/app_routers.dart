import 'package:conet_app/features/authentication/view/create_account.dart';
import 'package:conet_app/features/onboarding/view/interest_screen.dart';
import 'package:conet_app/features/authentication/view/login.dart';
import 'package:conet_app/features/home/home_page.dart';
import 'package:conet_app/features/initial_screen/onboarding.dart';
import 'package:conet_app/features/onboarding/view/learning_screen.dart';
import 'package:conet_app/features/onboarding/view/skill_screen.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  static final router = GoRouter(
    initialLocation: "/onboarding",

    routes: [
      GoRoute(
        path: "/onboarding",
        name: 'onboarding',
        builder: (context, state) => const Onboarding(),
      ),

      GoRoute(
        path: "/login",
        name: 'login',
        builder: (context, state) => const LoginScreen(),
      ),

      GoRoute(
        path: "/createAcc",
        name: 'createAcc',
        builder: (context, state) => const CreateAccount(),
      ),

      GoRoute(
        path: "/home",
        name: 'home',
        builder: (context, state) => const HomePage(),
      ),

      GoRoute(
        path: "/interest",
        name: 'interest',
        builder: (context, state) => const InterestScreen(),
      ),

      GoRoute(
        path: "/skill",
        name: 'skill',
        builder: (context, state) {
          final interests = state.extra as List<String>;

          return SkillsScreen(interests: interests);
        },
      ),

      GoRoute(
        path: "/learn",
        name: 'learn',
        builder: (context, state) {
          final data = state.extra as Map<String, dynamic>;

          return LearningScreen(
            interests: data["interests"],
            skills: data["skills"],
          );
        },
      ),
    ],
  );
}
