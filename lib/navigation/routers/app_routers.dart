import 'package:conet_app/features/authentication/view/create_account.dart';
import 'package:conet_app/features/authentication/view/login.dart';
import 'package:conet_app/features/home/home_page.dart';
import 'package:conet_app/features/onboarding/onboarding_screen/onboarding.dart';
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
    ],
  );
}
