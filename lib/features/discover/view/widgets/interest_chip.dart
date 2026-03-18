import 'package:conet_app/features/discover/model/discover_user_model.dart';
import 'package:conet_app/util/constant/colors.dart';
import 'package:conet_app/util/helpers/helpers.dart';
import 'package:flutter/material.dart';

class InterestChip extends StatelessWidget {
  final DiscoverUser user;
  const InterestChip({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    final dark = AppHelpers.isDarkMode(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: dark ? AppColors.skillChipdark : AppColors.skillChiplight,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Text(
        user.interest,
        style: Theme.of(context).textTheme.labelLarge!.copyWith(
          fontWeight: FontWeight.bold,
          color: AppColors.skillLabel,
        ),
      ),
    );
  }
}
