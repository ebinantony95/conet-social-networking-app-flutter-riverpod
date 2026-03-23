import 'package:conet_app/util/constant/colors.dart';
import 'package:flutter/material.dart';

class ConnectButton extends StatelessWidget {
  final VoidCallback onPressed;
  const ConnectButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      width: 110,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),

        color: AppColors.gradientColor2,
      ),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          child: Text(
            "Connect",
            style: Theme.of(
              context,
            ).textTheme.bodyLarge!.copyWith(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
