import 'package:conet_app/features/post/view/widgets/post_dialog.dart';
import 'package:conet_app/features/profile/view/widgets/custom_containers.dart';
import 'package:conet_app/features/profile/view/widgets/image_container.dart';
import 'package:conet_app/features/post/post_button.dart';
import 'package:conet_app/features/profile/view_model/profile_view_model.dart';
import 'package:conet_app/util/constant/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProfilePage extends ConsumerStatefulWidget {
  final String uid;
  const ProfilePage({super.key, required this.uid});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ProfilePageState();
}

class _ProfilePageState extends ConsumerState<ProfilePage> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      ref.read(profileProvider.notifier).loadProfile(widget.uid);
    });
  }

  @override
  Widget build(BuildContext context) {
    final profileState = ref.watch(profileProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Profile",
          style: Theme.of(
            context,
          ).textTheme.headlineMedium!.copyWith(fontWeight: FontWeight.w900),
        ),
      ),
      body: profileState.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text("Error: $e")),
        data: (profile) {
          if (profile == null) {
            return const Center(child: Text("No Profile"));
          }

          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // image...........
                    ImageContainer(profile: profile),

                    SizedBox(height: 20),
                    // name..............
                    Text(
                      profile.name,
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    const SizedBox(height: 20),
                    // bio........
                    SizedBox(
                      width: 250,
                      child: Text(
                        textAlign: TextAlign.center,
                        profile.bio,
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                    ),
                    const SizedBox(height: 50),

                    SizedBox(height: 20),
                    // interest...................................
                    CustomContainers(
                      darkcolor: AppColors.intertestChipdark,
                      lightColor: AppColors.intertestChiplight,
                      textColor: AppColors.interestLabel,
                      text: 'Interests:',
                      items: profile.interests,
                    ),

                    SizedBox(height: 20),

                    // skills...................................
                    CustomContainers(
                      darkcolor: AppColors.skillChipdark,
                      lightColor: AppColors.skillChiplight,
                      textColor: AppColors.skillLabel,
                      text: 'Skills I Can Share:',
                      items: profile.skillsHave,
                    ),

                    SizedBox(height: 20),

                    // learning...................................
                    CustomContainers(
                      darkcolor: AppColors.learnChipdark,
                      lightColor: AppColors.learnChiplight,
                      textColor: AppColors.learnLabel,
                      text: 'Skill I Want to Learn:',
                      items: profile.skillsLearn,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
      //post.....
      floatingActionButton: GestureDetector(
        onTap: () {
          openCreatePostDialog(context);
        },
        child: PostButton(),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}

//dialog.....
void openCreatePostDialog(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: true,
    builder: (_) => const CreatePostDialog(),
  );
}
