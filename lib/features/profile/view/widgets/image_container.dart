import 'package:conet_app/features/profile%20image%20bio.dart/view/screens/edit_profile_sheet.dart';
import 'package:conet_app/features/profile/model/profile_model.dart';
import 'package:conet_app/util/constant/colors.dart';
import 'package:conet_app/util/helpers/helpers.dart';
import 'package:flutter/material.dart';

class ImageContainer extends StatelessWidget {
  final UserProfile profile;
  const ImageContainer({super.key, required this.profile});

  @override
  Widget build(BuildContext context) {
    final dark = AppHelpers.isDarkMode(context);
    return Container(
      width: 180,
      height: 180,
      decoration: BoxDecoration(
        color: dark ? AppColors.dark : AppColors.bright,
        borderRadius: BorderRadius.circular(50),
      ),
      child: Stack(
        children: [
          /// Avatar
          Positioned(
            top: 20,
            bottom: 20,
            right: 10,
            left: 10,
            child: Image.asset(profile.avatar, fit: BoxFit.cover),
          ),

          /// Edit button
          Positioned(
            bottom: 0,
            right: 0,
            left: 0,
            top: 0,
            child: IconButton(
              icon: const Icon(
                size: 150,
                Icons.mode_standby_outlined,
                color: Colors.transparent,
              ),
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  builder: (_) => EditProfileSheet(profile: profile),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
