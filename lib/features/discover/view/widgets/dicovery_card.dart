import 'package:conet_app/features/discover/model/discover_user_model.dart';
import 'package:conet_app/util/constant/colors.dart';
import 'package:conet_app/util/constant/images.dart';
import 'package:conet_app/util/helpers/helpers.dart';
import 'package:flutter/material.dart';

class DiscoverCard extends StatelessWidget {
  final DiscoverUser user;
  final VoidCallback onClose;
  final VoidCallback onConnect;

  const DiscoverCard({
    super.key,
    required this.user,
    required this.onClose,
    required this.onConnect,
  });

  @override
  Widget build(BuildContext context) {
    final dark = AppHelpers.isDarkMode(context);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 20,
            offset: Offset(0, 10),
          ),
        ],
        borderRadius: BorderRadius.circular(20),
        color: dark ? AppColors.containerDark : AppColors.containerLight,
      ),
      child: Column(
        children: [
          /// ❌ button
          Align(
            alignment: Alignment.topRight,
            child: GestureDetector(
              onTap: onClose,
              child: const Icon(Icons.close, size: 18),
            ),
          ),

          const SizedBox(height: 8),

          /// Avatar
          ///
          Container(
            width: 70,
            height: 70,
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
          ),

          // ///
          // CircleAvatar(
          //   radius: 30,
          //   backgroundImage: user.avatar.startsWith('http')
          //       ? NetworkImage(user.avatar)
          //       : AssetImage(user.avatar) as ImageProvider,
          // ),
          const SizedBox(height: 10),

          /// Name
          Text(
            user.name,
            style: Theme.of(
              context,
            ).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 10),

          /// Interest
          Container(
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
          ),

          const SizedBox(height: 10),

          /// Learning
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Want to Learn: ",
                style: Theme.of(context).textTheme.labelLarge!.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                ),
              ),
              Text(
                user.wantsToLearn,
                style: Theme.of(context).textTheme.labelLarge!.copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppColors.learnLabel,
                ),
              ),
            ],
          ),
          const Spacer(),

          /// Connect button
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              gradient: LinearGradient(
                colors: [AppColors.gradientColor1, AppColors.gradientColor2],
              ),
            ),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: onConnect,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
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
          ),
          SizedBox(height: 10),
        ],
      ),
    );
  }
}
