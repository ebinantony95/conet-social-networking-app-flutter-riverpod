import 'package:conet_app/common/custom_icon_buttton.dart';
import 'package:conet_app/features/authentication/view_model/auth_viewmodel_provider.dart';
import 'package:conet_app/util/constant/colors.dart';
import 'package:conet_app/util/constant/images.dart';
import 'package:conet_app/util/helpers/helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeAppBar extends ConsumerWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dark = AppHelpers.isDarkMode(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
      ),
      child: SafeArea(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            /// 🔹 Logo
            Row(
              children: [
                SizedBox(
                  width: 150,
                  child: Image.asset(
                    dark ? Appimages.conetDark : Appimages.conetLight,
                  ),
                ),
              ],
            ),

            /// 🔹 Right Icons
            Row(
              children: [
                CustomIconButtton(
                  icon: dark ? Icons.sunny : Icons.dark_mode,
                  onTap: () {
                    // TODO: Toggle theme
                  },
                  iconColor: dark ? Colors.white : Colors.black,
                  containerColor: dark
                      ? AppColors.containerDark
                      : AppColors.containerLight,
                ),
                SizedBox(width: 10),
                CustomIconButtton(
                  icon: Icons.logout,
                  onTap: () {
                    ref.read(authViewModelProvider.notifier).logout();
                  },
                  iconColor: dark ? Colors.white : Colors.black,
                  containerColor: dark
                      ? AppColors.containerDark
                      : AppColors.containerLight,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
