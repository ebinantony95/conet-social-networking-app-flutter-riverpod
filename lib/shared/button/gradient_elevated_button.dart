import 'package:conet_app/util/constant/colors.dart';
import 'package:flutter/material.dart';

class GradientElevatedButton extends StatelessWidget {
  final Widget child;
  final VoidCallback? onPressed;
  final double height;
  final double borderRadius;

  const GradientElevatedButton({
    super.key,
    required this.child,
    this.onPressed,
    required this.height,
    required this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return
    /// Button
    SizedBox(
      width: double.infinity,
      height: height,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          padding: EdgeInsets.zero,
        ),
        child: Ink(
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [AppColors.gradientColor1, AppColors.gradientColor2],
            ),
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          child: Center(child: child),
        ),
      ),
    );
  }
}
