import 'package:conet_app/features/authentication/view/provider/auth_state_provider.dart';
import 'package:conet_app/features/home/view/provider/friend_counter_provider.dart';
import 'package:conet_app/features/home/view/widgets/home_appbar.dart';
import 'package:conet_app/features/home/view/widgets/home_post_card.dart';
import 'package:conet_app/features/post/view model/post_view_model.dart';
import 'package:conet_app/util/constant/colors.dart';
import 'package:conet_app/util/helpers/helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dark = AppHelpers.isDarkMode(context);
    final userState = ref.watch(authStateProvider);

    return userState.when(
      ///  AUTH LOADING
      loading: () =>
          const Scaffold(body: Center(child: CircularProgressIndicator())),

      ///  AUTH ERROR
      error: (e, _) => Scaffold(body: Center(child: Text("Error: $e"))),

      /// AUTH SUCCESS
      data: (user) {
        if (user == null) {
          return const Scaffold(
            body: Center(child: Text("User not logged in")),
          );
        }

        final userId = user.uid;

        final matchCount = ref.watch(matchCountProvider(userId));
        final postsState = ref.watch(postViewModelProvider);

        return SafeArea(
          child: Scaffold(
            /// IMPORTANT: Use ListView instead of Column
            body: ListView(
              children: [
                /// CUSTOM APP BAR
                HomeAppBar(),

                /// FRIEND COUNT HEADER (SCROLLS NOW)
                matchCount.when(
                  data: (count) => Container(
                    height: 80,
                    margin: const EdgeInsets.all(16),
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: dark
                            ? [
                                AppColors.homeGr1bl,
                                AppColors.homeGr2bl,
                                AppColors.homeGr3bl,
                              ]
                            : [
                                AppColors.homeGr1,
                                AppColors.homeGr2,
                                AppColors.homeGr3,
                              ],
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.celebration,
                          color: Colors.white,
                          size: 30,
                        ),
                        const SizedBox(width: 10),

                        ///  prevent overflow
                        Expanded(
                          child: Text(
                            count == 1
                                ? "1 Friend"
                                : "You gained $count matches",
                            style: Theme.of(context).textTheme.titleLarge!
                                .copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  /// 🔄 MATCH LOADING
                  loading: () => const Padding(
                    padding: EdgeInsets.all(16),
                    child: Center(child: CircularProgressIndicator()),
                  ),

                  ///  MATCH ERROR
                  error: (e, _) =>
                      const Center(child: Text("Failed to load friends")),
                ),

                /// POSTS
                postsState.when(
                  data: (posts) {
                    if (posts.isEmpty) {
                      return const Padding(
                        padding: EdgeInsets.all(20),
                        child: Center(child: Text("No posts yet 🚀")),
                      );
                    }

                    return ListView.builder(
                      itemCount: posts.length,
                      shrinkWrap: true, // IMPORTANT
                      physics:
                          const NeverScrollableScrollPhysics(), //  IMPORTANT
                      itemBuilder: (context, index) {
                        return PostCard(post: posts[index]);
                      },
                    );
                  },

                  /// POSTS LOADING
                  loading: () => const Padding(
                    padding: EdgeInsets.all(20),
                    child: Center(child: CircularProgressIndicator()),
                  ),

                  ///  POSTS ERROR
                  error: (e, _) => Padding(
                    padding: const EdgeInsets.all(20),
                    child: Center(child: Text(e.toString())),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
