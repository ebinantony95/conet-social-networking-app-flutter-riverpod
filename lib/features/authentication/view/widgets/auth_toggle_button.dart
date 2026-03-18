import 'package:flutter/material.dart';

class AuthToggleButton extends StatelessWidget {
  final VoidCallback ontap;
  final String label;
  final Color color;
  final String accQn;
  const AuthToggleButton({
    super.key,
    required this.ontap,
    required this.label,
    required this.color,
    required this.accQn,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(accQn),
        GestureDetector(
          onTap: ontap,
          child: Text(
            label,
            style: TextStyle(color: color, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}
