import 'package:conet_app/util/helpers/helpers.dart';
import 'package:flutter/material.dart';

class CustomProfilechip extends StatelessWidget {
  final String label;
  final Color darkcolor;
  final Color lightColor;
  final Color textColor;

  const CustomProfilechip({
    super.key,

    required this.darkcolor,
    required this.lightColor,
    required this.label,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    final dark = AppHelpers.isDarkMode(context);
    return Container(
      height: 45,
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 14),

      decoration: BoxDecoration(
        color: dark ? darkcolor : lightColor,

        borderRadius: BorderRadius.circular(30),
      ),
      child: Text(
        label,
        style: Theme.of(
          context,
        ).textTheme.labelLarge!.copyWith(color: textColor),
      ),
    );
  }
}
