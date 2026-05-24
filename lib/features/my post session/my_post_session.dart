import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:conet_app/features/post/view%20model/post_view_model.dart';
import 'package:conet_app/features/post/view/provider/user_post_provider.dart';
import 'package:conet_app/util/constant/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MyPostSession extends ConsumerWidget {
  final String userId;
  const MyPostSession({super.key, required this.userId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userPosts = ref.watch(userPostsProvider(userId));
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 20),

        /// TITLE
        Text("My Posts", style: Theme.of(context).textTheme.titleLarge),

        const SizedBox(height: 12),

        /// POSTS
        userPosts.when(
          loading: () => const Center(child: CircularProgressIndicator()),

          error: (e, _) => Text("Error: $e"),

          data: (posts) {
            if (posts.isEmpty) {
              return const Text("No posts yet");
            }

            return SizedBox(
              height: 130,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: posts.length,
                itemBuilder: (context, index) {
                  final post = posts[index];

                  return GestureDetector(
                    onLongPress: () async {
                      final confirm = await showDialog<bool>(
                        context: context,
                        builder: (dialogContext) => AlertDialog(
                          title: const Text("Delete post?"),
                          actions: [
                            TextButton(
                              onPressed: () =>
                                  Navigator.of(dialogContext).pop(false),
                              child: const Text("Cancel"),
                            ),
                            TextButton(
                              onPressed: () =>
                                  Navigator.of(dialogContext).pop(true),
                              child: const Text("Delete"),
                            ),
                          ],
                        ),
                      );

                      if (confirm == true) {
                        await ref
                            .read(postViewModelProvider.notifier)
                            .deletePost(post.id);
                      }
                    },
                    child: Container(
                      width: 260,

                      margin: const EdgeInsets.only(right: 12),
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        border: Border.all(),
                        gradient: LinearGradient(
                          colors: [
                            AppColors.postGr.withValues(alpha: .3),
                            AppColors.postGr2.withValues(alpha: .3),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Stack(
                        children: [
                          ///  CONTENT
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                post.content,
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(height: 1.4),
                              ),
                            ),
                          ),

                          ///  DATE
                          Align(
                            alignment: Alignment.bottomRight,
                            child: Text(
                              formatDate(post.createdAt),
                              style: const TextStyle(fontSize: 10),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            );
          },
        ),
      ],
    );
  }
}

//date formater...
String formatDate(Timestamp timestamp) {
  final date = timestamp.toDate();
  return "${date.day} ${_month(date.month)} ${date.year}";
}

String _month(int m) {
  const months = [
    "Jan",
    "Feb",
    "Mar",
    "Apr",
    "May",
    "Jun",
    "Jul",
    "Aug",
    "Sep",
    "Oct",
    "Nov",
    "Dec",
  ];
  return months[m - 1];
}
