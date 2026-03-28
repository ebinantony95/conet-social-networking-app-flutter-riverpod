import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:conet_app/features/authentication/model/user_model.dart';
import 'package:conet_app/features/authentication/view/provider/auth_state_provider.dart';
import 'package:conet_app/features/authentication/view/screens/create_account.dart';
import 'package:conet_app/features/authentication/view/screens/login.dart';
import 'package:conet_app/features/chat/view/screen/chat_screen.dart';
import 'package:conet_app/features/friends%20match/view/screens/firends_page.dart';
import 'package:conet_app/features/landing_page/landing_page.dart';
import 'package:conet_app/features/home/home_page.dart';
import 'package:conet_app/features/landing_page/landing_provider.dart';
import 'package:conet_app/features/match%20success/match_success_screen.dart';
import 'package:conet_app/features/match/view/screens/match_page.dart';
import 'package:conet_app/features/onboarding/view/screens/interest_screen.dart';
import 'package:conet_app/features/onboarding/view/screens/learning_screen.dart';
import 'package:conet_app/features/onboarding/view/screens/skill_screen.dart';
import 'package:conet_app/features/profile/view/screens/profile_page.dart';
import 'package:conet_app/navigation/bottomNAVbar/bottom_nav_shell.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final routerProvider = Provider<GoRouter>((ref) {
  final authState = ref.watch(authStateProvider);
  final landingAsync = ref.watch(landingStatusProvider);

  return GoRouter(
    initialLocation: "/",

    redirect: (context, state) async {
      if (authState.isLoading) return null;

      if (landingAsync.isLoading) return null;

      final user = authState.value;
      final isLoggedIn = user != null;
      final seenLanding = landingAsync.value ?? false;

      //match locations......
      final location = state.matchedLocation;

      final landingRoute = location == '/landing';

      final onboardingRoute =
          location == '/interest' ||
          location == '/skill' ||
          location == '/learn';

      final authRoute = location == '/login' || location == '/createAcc';

      if (location == "/") {
        if (!seenLanding) return "/landing";

        if (!isLoggedIn) return "/login";

        final doc = await FirebaseFirestore.instance
            .collection("users")
            .doc(user.uid)
            .get();

        final completed = doc.data()?["profileCompleted"] ?? false;

        if (!completed) return "/interest";

        return "/profile/${user.uid}";
      }

      /// 1️⃣ Landing page
      if (!seenLanding && !landingRoute && !isLoggedIn && !onboardingRoute) {
        return "/landing";
      }

      /// 2️⃣ Not logged in
      if (!isLoggedIn) {
        return authRoute ? null : "/login";
      }

      /// 3️⃣ Logged in → prevent going back to login
      if (isLoggedIn && authRoute) {
        return "/profile/${user.uid}";
      }

      /// 4️⃣ Onboarding check
      final doc = await FirebaseFirestore.instance
          .collection("users")
          .doc(user.uid)
          .get();

      final completed = doc.data()?["profileCompleted"] ?? false;

      if (!completed && !onboardingRoute) {
        return "/interest";
      }

      if (completed && onboardingRoute) {
        return "/profile/${user.uid}";
      }

      return null;
    },
    routes: [
      GoRoute(
        path: "/",
        builder: (context, state) =>
            const Scaffold(body: Center(child: CircularProgressIndicator())),
      ),
      GoRoute(
        path: "/landing",
        name: "landing",
        builder: (context, state) => const LandingPage(),
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

      GoRoute(
        path: '/match-success',
        name: 'match-success',
        pageBuilder: (context, state) {
          final user = state.extra as UserModel;

          return CustomTransitionPage(
            child: MatchSuccessPage(user: user, currentUserId: user.uid),
            transitionsBuilder: (context, animation, secAnimation, child) {
              return FadeTransition(opacity: animation, child: child);
            },
          );
        },
      ),

      GoRoute(
        path: '/chat',
        builder: (context, state) {
          final data = state.extra as Map<String, dynamic>;

          return ChatScreen(
            chatId: data['chatId'],
            currentUserId: data['currentUserId'],
          );
        },
      ),

      // main app with Bottom NAV bar
      ShellRoute(
        builder: (context, state, child) => BottomNavshell(child: child),
        routes: [
          // home.........
          GoRoute(
            path: '/home',
            name: 'home',
            builder: (context, state) => HomePage(),
          ),

          //match......
          GoRoute(
            path: '/match',
            name: 'match',
            builder: (context, state) => MatchPage(),
          ),
          //friends...
          GoRoute(
            path: '/friends',
            name: 'friends',
            builder: (context, state) => FriendsPage(),
          ),
          //profile...
          GoRoute(
            path: '/profile/:uid',
            name: 'profile',
            builder: (context, state) {
              final uid = state.pathParameters['uid']!;
              return ProfilePage(uid: uid);
            },
          ),
        ],
      ),
    ],
  );
});
