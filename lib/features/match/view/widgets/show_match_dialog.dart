import 'package:conet_app/features/authentication/model/user_model.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

void showMatchDialog(BuildContext context, UserModel user) {
  showDialog(
    context: context,
    builder: (dialogContext) {
      return AlertDialog(
        title: const Text("It's a Match 🎉"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("You matched with ${user.name}"),
            const SizedBox(height: 10),
            CircleAvatar(radius: 40, backgroundImage: AssetImage(user.avatar)),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(dialogContext); // ✅ safest
            },
            child: const Text("Keep Exploring"),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(dialogContext); // close dialog first
              context.push('/chat'); // then navigate
            },
            child: const Text("Chat"),
          ),
        ],
      );
    },
  );
}
