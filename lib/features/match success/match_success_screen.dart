import 'package:conet_app/features/authentication/model/user_model.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MatchSuccessPage extends StatelessWidget {
  final UserModel user;

  const MatchSuccessPage({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            /// ICON
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                gradient: const LinearGradient(
                  colors: [Color(0xFFE94057), Color(0xFF8A3AB9)],
                ),
              ),
              child: const Icon(Icons.favorite, color: Colors.white, size: 40),
            ),

            const SizedBox(height: 20),

            Text(
              "It's a Match! 🎉",
              style: Theme.of(context).textTheme.headlineLarge,
            ),

            const SizedBox(height: 10),

            Text(
              "You matched with ${user.name}",
              style: const TextStyle(color: Colors.grey),
            ),

            const SizedBox(height: 20),

            CircleAvatar(radius: 50, backgroundImage: AssetImage(user.avatar)),

            const SizedBox(height: 30),

            /// BUTTONS
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _btn(
                  "Keep Exploring",
                  Colors.grey.shade300,
                  () => context.pop(),
                  textColor: Colors.black,
                ),
                const SizedBox(width: 10),
                _btn(
                  "Chat",
                  const LinearGradient(
                    colors: [Color(0xFFE94057), Color(0xFF8A3AB9)],
                  ),
                  () {
                    context.pop(); // close match screen
                    context.push('/chat'); // go to chat
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _btn(
    String text,
    dynamic color,
    VoidCallback onTap, {
    Color textColor = Colors.white,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        decoration: BoxDecoration(
          gradient: color is Gradient ? color : null,
          color: color is Color ? color : null,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          text,
          style: TextStyle(color: textColor, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}
