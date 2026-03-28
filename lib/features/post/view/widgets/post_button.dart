import 'package:conet_app/util/constant/colors.dart';
import 'package:flutter/material.dart';

class PostButton extends StatelessWidget {
  const PostButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: 100,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.postGr.withValues(alpha: .3),
            AppColors.postGr2.withValues(alpha: .3),
          ],
        ),

        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [SizedBox(width: 19), Text('Post'), Icon(Icons.add)],
      ),
    );
  }
}
