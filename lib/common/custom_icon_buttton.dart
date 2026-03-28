import 'package:flutter/material.dart';

class CustomIconButtton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  final Color iconColor;
  final Color containerColor;

  const CustomIconButtton({
    super.key,
    required this.icon,
    required this.onTap,
    required this.iconColor,
    required this.containerColor,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: containerColor,
          shape: BoxShape.circle,
        ),
        child: Icon(
          icon,
          size: 22,
          color: iconColor, // 👈 apply color here
        ),
      ),
    );
  }
}
