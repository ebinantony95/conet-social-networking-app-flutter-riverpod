import 'package:conet_app/features/discover/model/discover_user_model.dart';
import 'package:conet_app/util/constant/colors.dart';
import 'package:flutter/material.dart';

class LearningArea extends StatelessWidget {
  final DiscoverUser user;
  const LearningArea({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Want to Learn: ",
          style: Theme.of(context).textTheme.labelLarge!.copyWith(
            fontWeight: FontWeight.bold,
            color: Colors.grey,
          ),
        ),
        Expanded(
          child: Text(
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            user.wantsToLearn,
            style: Theme.of(context).textTheme.labelLarge!.copyWith(
              fontWeight: FontWeight.bold,
              color: AppColors.learnLabel,
            ),
          ),
        ),
      ],
    );
  }
}
