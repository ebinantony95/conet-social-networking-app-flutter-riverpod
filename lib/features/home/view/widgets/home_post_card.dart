import 'package:conet_app/features/post/model/post_model.dart';
import 'package:conet_app/features/post/view%20model/post_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PostCard extends ConsumerWidget {
  final PostModel post;

  const PostCard({super.key, required this.post});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final date = post.createdAt?.toDate() ?? DateTime.now();

    return Container(
      margin: const EdgeInsets.all(12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.green.shade200,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// 👤 HEADER
          Row(
            children: [
              CircleAvatar(backgroundImage: NetworkImage(post.userAvatar)),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    post.userName,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "${date.day}/${date.month}/${date.year}",
                    style: const TextStyle(fontSize: 12),
                  ),
                ],
              ),
            ],
          ),

          const SizedBox(height: 10),

          /// ✍️ CONTENT
          Text(post.content),

          const SizedBox(height: 10),

          /// ❤️ LIKE BUTTON
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.favorite_border),
                onPressed: () {
                  ref.read(postViewModelProvider.notifier).likePost(post.id);
                },
              ),
              Text(post.likesCount.toString()),
            ],
          ),
        ],
      ),
    );
  }
}
