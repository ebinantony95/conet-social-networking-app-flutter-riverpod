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
        border: Border.all(color: Colors.grey),
      ),
      child: Stack(
        children: [
          /// Avatar
          Positioned(
            left: 10,
            right: 10,
            bottom: 10,
            top: 10,
            child: Image.asset(profile.avatar),
          ),

          // Center(
          //   child: CircleAvatar(
          //     radius: 70,
          //     backgroundColor: Colors.transparent,
          //     backgroundImage: profile.avatar.isNotEmpty
          //         ? AssetImage(profile.avatar)
          //         : null,
          //     child: profile.avatar.isEmpty
          //         ? const Icon(Icons.person, size: 40)
          //         : null,
          //   ),
          // ),

          /// Edit button
          Positioned(
            right: 0,
            bottom: 0,
            child: IconButton(
              icon: const Icon(Icons.edit),
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
