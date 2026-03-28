// import 'package:conet_app/features/authentication/view_model/auth_viewmodel_provider.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';

// class HomePage extends ConsumerWidget {
//   const HomePage({super.key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     return Scaffold(
//       body: Center(
//         child: ElevatedButton(
//           onPressed: () {
//             ref.read(authViewModelProvider.notifier).logout();
//           },
//           child: Text('home'),
//         ),
//       ),
//     );
//   }
// }

import 'package:conet_app/features/home/view/provider/friend_counter_provider.dart';
import 'package:conet_app/features/home/view/widgets/home_post_card.dart';
import 'package:conet_app/features/post/view%20model/post_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final postsState = ref.watch(postViewModelProvider);
    final friendsState = ref.watch(friendsCountProvider);

    return Scaffold(
      appBar: AppBar(title: const Text("Home")),
      body: Column(
        children: [
          /// FRIEND COUNT CARD
          friendsState.when(
            data: (count) => Container(
              margin: const EdgeInsets.all(16),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Colors.purple, Colors.orange],
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                children: [
                  const Icon(Icons.people, color: Colors.white),
                  const SizedBox(width: 10),
                  Text(
                    "$count Friends",
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            loading: () => const CircularProgressIndicator(),
            error: (e, _) => const Text("Error"),
          ),

          /// 📰 POSTS
          Expanded(
            child: postsState.when(
              data: (posts) {
                if (posts.isEmpty) {
                  return const Center(child: Text("No posts yet 🚀"));
                }

                return ListView.builder(
                  itemCount: posts.length,
                  itemBuilder: (context, index) {
                    return PostCard(post: posts[index]);
                  },
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (e, _) => Center(child: Text(e.toString())),
            ),
          ),
        ],
      ),
    );
  }
}
