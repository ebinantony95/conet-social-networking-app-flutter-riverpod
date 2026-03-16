import 'package:conet_app/features/profile/view/widgets/custom_containers.dart';
import 'package:conet_app/features/profile/view/widgets/custom_profilechip.dart';
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
                    Container(
                      width: 130,
                      height: 135,
                      color: AppColors.chipColor,
                    ),
                    SizedBox(height: 20),
                    // name..............
                    Text(
                      profile.name,
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    const SizedBox(height: 20),
                    // bio........
                    Text("Bio: ${profile.bio}"),
                    const SizedBox(height: 20),

                    // interest...................................
                    CustomContainers(
                      child: Column(
                        children: [
                          Text(
                            'Interests:',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          SizedBox(height: 20),
                          Wrap(
                            spacing: 10,
                            runSpacing: 10,
                            children: profile.interests
                                .map(
                                  (e) => CustomProfilechip(
                                    darkcolor: AppColors.intertestChipdark,
                                    lightColor: AppColors.intertestChiplight,
                                    label: e,
                                    textColor: AppColors.interestLabel,
                                  ),
                                )
                                .toList(),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),

                    // skills...................................
                    CustomContainers(
                      child: Column(
                        children: [
                          Text(
                            'Skills I Can Share:',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          SizedBox(height: 20),
                          Wrap(
                            spacing: 10,
                            runSpacing: 10,
                            children: profile.skillsHave
                                .map(
                                  (e) => CustomProfilechip(
                                    darkcolor: AppColors.skillChipdark,
                                    lightColor: AppColors.skillChiplight,
                                    label: e,
                                    textColor: AppColors.skillLabel,
                                  ),
                                )
                                .toList(),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),

                    // learning...................................
                    CustomContainers(
                      child: Column(
                        children: [
                          Text(
                            'Skill I Want to Learn:',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          SizedBox(height: 20),
                          Wrap(
                            spacing: 10,
                            runSpacing: 10,
                            children: profile.skillsLearn
                                .map(
                                  (e) => CustomProfilechip(
                                    darkcolor: AppColors.learnChipdark,
                                    lightColor: AppColors.learnChiplight,
                                    label: e,
                                    textColor: AppColors.learnLabel,
                                  ),
                                )
                                .toList(),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
