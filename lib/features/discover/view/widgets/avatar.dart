import 'package:conet_app/features/discover/model/discover_user_model.dart';
import 'package:conet_app/util/constant/colors.dart';
import 'package:conet_app/util/constant/images.dart';
import 'package:conet_app/util/helpers/helpers.dart';
import 'package:flutter/material.dart';

class Avatar extends StatelessWidget {
  final DiscoverUser user;

  const Avatar({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    final dark = AppHelpers.isDarkMode(context);
    return Container(
      width: 100,
      height: 120,
      decoration: BoxDecoration(
        color: dark ? AppColors.containerDark : AppColors.containerLight,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey),
      ),
      child: Image(
        image: user.avatar.isNotEmpty
            ? AssetImage(user.avatar)
            : AssetImage(Appimages.defaultAvatar),
      ),
    );
  }
}
