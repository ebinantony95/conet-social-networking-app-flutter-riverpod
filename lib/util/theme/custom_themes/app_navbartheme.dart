import 'package:flutter/material.dart';

class AppNavbartheme {
  /// Light theme navbar
  static BottomNavigationBarThemeData light = BottomNavigationBarThemeData(
    backgroundColor: Colors.white,
    selectedItemColor: Colors.black,
    unselectedItemColor: Colors.grey,
    // selectedLabelStyle: const TextStyle(fontWeight: FontWeight.w500),
    // unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.w500),
    type: BottomNavigationBarType.fixed,
  );

  /// Dark theme navbar
  static BottomNavigationBarThemeData dark = BottomNavigationBarThemeData(
    backgroundColor: const Color(0xFF0E0E0E),
    selectedItemColor: Colors.white,
    unselectedItemColor: Colors.grey,
    // selectedLabelStyle: const TextStyle(fontWeight: FontWeight.w500),
    // unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.w500),
    type: BottomNavigationBarType.fixed,
  );
}
