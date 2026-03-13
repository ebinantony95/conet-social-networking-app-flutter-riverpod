import 'package:conet_app/util/constant/colors.dart';
import 'package:flutter/material.dart';

class SelectableChip extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const SelectableChip({
    super.key,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,

      child: Container(
        height: 50,
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 13),

        decoration: BoxDecoration(
          color: selected ? AppColors.chipSelectColor : AppColors.chipColor,

          borderRadius: BorderRadius.circular(30),
        ),

        child: Text(
          label,
          style: Theme.of(context).textTheme.titleMedium!.copyWith(
            color: selected ? Colors.white : Colors.black,
          ),
          // style: TextStyle(color: selected ? Colors.white : Colors.black),
        ),
      ),
    );
  }
}
