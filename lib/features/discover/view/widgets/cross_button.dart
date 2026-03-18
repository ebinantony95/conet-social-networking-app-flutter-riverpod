import 'package:flutter/material.dart';

class CrossButton extends StatelessWidget {
  final VoidCallback onClose;
  const CrossButton({super.key, required this.onClose});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topRight,
      child: GestureDetector(
        onTap: onClose,
        child: const Icon(Icons.close, size: 18),
      ),
    );
  }
}
