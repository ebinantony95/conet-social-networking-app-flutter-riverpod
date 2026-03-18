import 'package:conet_app/features/discover/model/discover_user_model.dart';
import 'package:conet_app/features/discover/view/widgets/avatar.dart';
import 'package:conet_app/features/discover/view/widgets/connect_button.dart';
import 'package:conet_app/features/discover/view/widgets/cross_button.dart';
import 'package:conet_app/features/discover/view/widgets/interest_chip.dart';
import 'package:conet_app/features/discover/view/widgets/learning_area.dart';
import 'package:conet_app/util/constant/colors.dart';
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
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            offset: Offset(0, 5),
          ),
        ],
        borderRadius: BorderRadius.circular(16),
        color: dark ? AppColors.containerDark : AppColors.containerLight,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Avatar
          Avatar(user: user),

          const SizedBox(width: 12),

          /// Content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// Top Row (Name + Close)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      user.name,
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    CrossButton(onClose: onClose),
                  ],
                ),

                const SizedBox(height: 6),

                /// Interest
                InterestChip(user: user),

                const SizedBox(height: 6),

                /// Learning
                LearningArea(user: user),

                const SizedBox(height: 10),

                /// Connect button
                ConnectButton(onPressed: onConnect),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
