import 'package:conet_app/features/authentication/model/user_model.dart';
import 'package:flutter/material.dart';

class MatchCard extends StatelessWidget {
  final UserModel user;

  const MatchCard({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        color: Colors.white,
        boxShadow: [
          BoxShadow(blurRadius: 20, color: Colors.black.withOpacity(0.05)),
        ],
      ),
      child: Column(
        children: [
          /// GRADIENT HEADER
          Container(
            height: 200,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
              gradient: LinearGradient(
                colors: [Color(0xFFE94057), Color(0xFF8A3AB9)],
              ),
            ),
            child: Center(
              child: CircleAvatar(
                radius: 50,
                backgroundImage: AssetImage(user.avatar),
              ),
            ),
          ),

          const SizedBox(height: 16),

          Text(
            user.name,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 8),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              user.bio,
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.grey),
            ),
          ),

          const SizedBox(height: 20),

          _section("SKILLS", user.skills, Colors.pink.shade100),
          _section("LEARNING", user.learning, Colors.purple.shade100),
          _section("INTERESTS", user.interests, Colors.orange.shade100),
        ],
      ),
    );
  }

  Widget _section(String title, List<String> items, Color color) {
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
          children: items
              .map((e) => Chip(label: Text(e), backgroundColor: color))
              .toList(),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
