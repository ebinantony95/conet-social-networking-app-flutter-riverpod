import 'package:conet_app/features/authentication/model/user_model.dart';
import 'package:conet_app/util/constant/colors.dart';
import 'package:conet_app/util/helpers/helpers.dart';
import 'package:flutter/material.dart';

class MatchCard extends StatelessWidget {
  final UserModel user;

  const MatchCard({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    final dark = AppHelpers.isDarkMode(context);
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: 520,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            color: dark ? AppColors.containerDark : AppColors.containerLight,
            boxShadow: [
              BoxShadow(blurRadius: 20, color: Colors.black.withOpacity(0.05)),
            ],
          ),
          child: Column(
            children: [
              /// GRADIENT HEADER
              Container(
                height: 130,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
                  gradient: LinearGradient(
                    colors: dark
                        ? [AppColors.homeGr1bl, AppColors.homeGr2bl]
                        : [AppColors.gradientColor1, AppColors.gradientColor2],
                  ),
                ),
                child: Center(
                  child: CircleAvatar(
                    backgroundColor: Colors.transparent,
                    radius: 40,
                    backgroundImage: AssetImage(user.avatar),
                  ),
                ),
              ),

              const SizedBox(height: 16),

              Text(
                user.name,
                style: Theme.of(context).textTheme.headlineMedium,
              ),

              const SizedBox(height: 8),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  user.bio,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.labelLarge,
                ),
              ),

              const SizedBox(height: 20),

              _section(
                "Skills I can share",
                user.skills,
                dark ? AppColors.skillChipdark : AppColors.skillChiplight,
                AppColors.skillLabel,
              ),
              _section(
                "Skill I want to learn",
                user.learning,
                dark ? AppColors.learnChipdark : AppColors.learnChiplight,
                AppColors.learnLabel,
              ),

              _section(
                "Interested in",
                user.interests,
                dark
                    ? AppColors.intertestChipdark
                    : AppColors.intertestChiplight,
                AppColors.interestLabel,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _section(
    String title,
    List<String> items,
    Color color,
    Color textColor,
  ) {
    final limitedItem = items.take(3).toList();
    return Column(
      children: [
        Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.grey,
          ),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          children: limitedItem
              .map(
                (e) => Chip(
                  label: Text(e, style: TextStyle(color: textColor)),
                  backgroundColor: color,
                ),
              )
              .toList(),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
