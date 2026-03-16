import 'package:conet_app/util/helpers/helpers.dart';
import 'package:flutter/material.dart';

class CustomProfilechip extends StatelessWidget {
  final Widget child;
  final Color darkcolor;
  final Color lightColor;
  const CustomProfilechip({
    super.key,
    required this.child,
    required this.darkcolor,
    required this.lightColor,
  });

  @override
  Widget build(BuildContext context) {
    final dark = AppHelpers.isDarkMode(context);
    return Container(
      height: 50,
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 13),

      decoration: BoxDecoration(
        color: dark ? darkcolor : lightColor,

        borderRadius: BorderRadius.circular(30),
      ),
      child: child,
    );
  }
}
