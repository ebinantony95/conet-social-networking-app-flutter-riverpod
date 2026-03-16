import 'package:conet_app/util/constant/sizes%20copy.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class BottomNavshell extends ConsumerWidget {
  final Widget child;
  const BottomNavshell({super.key, required this.child});

  int _getIndex(String location) {
    if (location.startsWith('/discover')) return 1;
    if (location.startsWith('/match')) return 2;
    if (location.startsWith('/request')) return 3;
    if (location.startsWith('/profile')) return 4;

    return 0;
  }

  void _ontap(BuildContext context, int index) {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    switch (index) {
      case 0:
        context.go('/home');
        break;
      case 1:
        context.go('/discover');
        break;
      case 2:
        context.go('/match');
        break;
      case 3:
        context.go('/request');
        break;
      case 4:
        context.go('/profile/$uid');
        break;
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final location = GoRouterState.of(context).uri.toString();
    final currentIndex = _getIndex(location);

    return Scaffold(
      body: child,
      bottomNavigationBar: SafeArea(
        top: false,
        child: SizedBox(
          height: AppSizes.navBarHeight,

          child: BottomNavigationBar(
            elevation: 0,
            currentIndex: currentIndex,
            onTap: (value) => _ontap(context, value),
            type: BottomNavigationBarType.fixed,
            iconSize: 26,
            selectedFontSize: 11,
            unselectedFontSize: 11,

            items: [
              const BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined),
                activeIcon: Icon(Icons.home),
                label: 'Home',
              ),
              const BottomNavigationBarItem(
                icon: Icon(Icons.find_replace_sharp),
                activeIcon: Icon(Icons.find_replace_sharp),
                label: 'Discover',
              ),

              BottomNavigationBarItem(
                icon: Icon(Icons.mark_chat_read_sharp),
                activeIcon: Icon(Icons.mark_chat_read_sharp),
                label: 'Match',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.compare_arrows_sharp),
                activeIcon: Icon(Icons.compare_arrows_sharp),
                label: 'Request',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person_outline),
                activeIcon: Icon(Icons.person),
                label: 'Profile',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
