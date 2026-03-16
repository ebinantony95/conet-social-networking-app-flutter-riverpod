import 'package:conet_app/util/constant/colors.dart';
import 'package:conet_app/util/helpers/helpers.dart';
import 'package:flutter/material.dart';

class CustomContainers extends StatelessWidget {
  final Widget child;
  const CustomContainers({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final dark = AppHelpers.isDarkMode(context);
    return // interests............
    Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: dark ? AppColors.containerDark : AppColors.containerLight,
        borderRadius: BorderRadius.circular(30),
      ),

      child: child,
    );
  }
}
