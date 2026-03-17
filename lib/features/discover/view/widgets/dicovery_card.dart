import 'package:conet_app/features/discover/model/discover_user_model.dart';
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
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.grey.shade900,
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
          CircleAvatar(
            radius: 30,
            backgroundImage: user.avatar.startsWith('http')
                ? NetworkImage(user.avatar)
                : AssetImage(user.avatar) as ImageProvider,
          ),

          const SizedBox(height: 8),

          /// Name
          Text(user.name, style: const TextStyle(fontWeight: FontWeight.bold)),

          const SizedBox(height: 6),

          /// Interest
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.pink,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(user.interest, style: const TextStyle(fontSize: 12)),
          ),

          const SizedBox(height: 6),

          /// Learning
          Text(
            "Wants: ${user.wantsToLearn}",
            style: const TextStyle(fontSize: 12),
          ),

          const Spacer(),

          /// Connect button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: onConnect,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.pink,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: const Text("Connect"),
            ),
          ),
        ],
      ),
    );
  }
}
