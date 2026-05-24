import 'package:conet_app/features/post/model/post_model.dart';
import 'package:conet_app/features/post/view%20model/post_view_model.dart';
import 'package:conet_app/util/helpers/helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PostCard extends ConsumerWidget {
  final PostModel post;

  const PostCard({super.key, required this.post});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dark = AppHelpers.isDarkMode(context);
    final date = post.createdAt.toDate();

    return Container(
      margin: const EdgeInsets.all(12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// HEADER
          Row(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundColor: Colors.grey.shade300,
                backgroundImage: AssetImage(
                  (post.avatar.isNotEmpty)
                      ? post.avatar
                      : 'assets/avatars/default_image.png',
                ),
              ),
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

          /// CONTENT
          Container(
            width: double.infinity,
            margin: const EdgeInsets.symmetric(vertical: 10),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              border: Border.all(
                color: dark ? Colors.white : Colors.black,
                width: 2,
              ),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(5),
                topRight: Radius.circular(30),
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
            ),
            child: Text(
              post.content,
              style: const TextStyle(fontSize: 16, height: 1.4),
            ),
          ),

          const SizedBox(height: 10),

          /// LIKE BUTTON
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
