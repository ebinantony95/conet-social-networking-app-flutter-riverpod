import 'package:conet_app/util/constant/colors.dart';
import 'package:flutter/material.dart';

class AppNavbartheme {
  /// Light theme navbar
  static BottomNavigationBarThemeData light = BottomNavigationBarThemeData(
    backgroundColor: Colors.white,
    selectedItemColor: AppColors.chipSelectColor,
    unselectedItemColor: Colors.grey,
    selectedLabelStyle: const TextStyle(fontWeight: FontWeight.w500),
    unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.w500),
    type: BottomNavigationBarType.fixed,
  );

  /// Dark theme navbar
  static BottomNavigationBarThemeData dark = BottomNavigationBarThemeData(
    backgroundColor: const Color(0xFF0E0E0E),
    selectedItemColor: AppColors.gradientColor1,
    unselectedItemColor: Colors.grey,
    selectedLabelStyle: const TextStyle(fontWeight: FontWeight.w500),
    unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.w500),
    type: BottomNavigationBarType.fixed,
  );
}
