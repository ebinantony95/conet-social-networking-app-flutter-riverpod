import 'package:conet_app/features/profile/view/widgets/custom_profilechip.dart';
import 'package:conet_app/util/constant/colors.dart';
import 'package:conet_app/util/helpers/helpers.dart';
import 'package:flutter/material.dart';

class CustomContainers extends StatelessWidget {
  final List<String> items;
  final Color darkcolor;
  final Color lightColor;
  final Color textColor;
  final String text;

  const CustomContainers({
    super.key,

    required this.darkcolor,
    required this.lightColor,
    required this.textColor,
    required this.text,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    final dark = AppHelpers.isDarkMode(context);
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: dark ? AppColors.containerDark : AppColors.containerLight,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 20,
            offset: Offset(0, 10),
          ),
        ],
      ),

      child: Column(
        children: [
          Text(text, style: Theme.of(context).textTheme.titleMedium),
          SizedBox(height: 20),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: items
                .map(
                  (e) => CustomProfilechip(
                    darkcolor: darkcolor,
                    lightColor: lightColor,
                    label: e,
                    textColor: textColor,
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }
}
