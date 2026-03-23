import 'package:conet_app/features/profile/model/profile_model.dart';
import 'package:conet_app/features/profile/view_model/profile_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class EditProfileSheet extends ConsumerStatefulWidget {
  final UserProfile profile;

  const EditProfileSheet({super.key, required this.profile});

  @override
  ConsumerState<EditProfileSheet> createState() => _EditProfileSheetState();
}

class _EditProfileSheetState extends ConsumerState<EditProfileSheet> {
  late TextEditingController bioController;
  String selectedAvatar = "";

  final avatars = [
    'assets/avatars/a1.png',
    'assets/avatars/a2.png',
    'assets/avatars/a3.png',
    'assets/avatars/a4.png',
    'assets/avatars/a5.png',
    'assets/avatars/a6.png',
    'assets/avatars/a7.png',
    'assets/avatars/a8.png',
    'assets/avatars/a9.png',
    'assets/avatars/a10.png',
    'assets/avatars/a11.png',
    'assets/avatars/a12.png',
    'assets/avatars/a13.png',
    'assets/avatars/a14.png',
    'assets/avatars/a15.png',
    'assets/avatars/a16.png',
    'assets/avatars/a17.png',
    'assets/avatars/a18.png',
    'assets/avatars/a19.png',
    'assets/avatars/a20.png',

    'assets/avatars/carlo.png',
    'assets/avatars/emma.png',
    'assets/avatars/hazel.png',
    'assets/avatars/jake.png',
    'assets/avatars/luke.png',
    'assets/avatars/maria.png',
    'assets/avatars/maxx.png',
    'assets/avatars/nikki.png',
    'assets/avatars/peter.png',
    'assets/avatars/ruby.png',
    'assets/avatars/sarah.png',
    'assets/avatars/victor.png',
  ];

  @override
  void initState() {
    super.initState();
    bioController = TextEditingController(text: widget.profile.bio);
    selectedAvatar = widget.profile.avatar;
  }

  @override
  void dispose() {
    bioController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 20,
        right: 20,
        top: 20,
        bottom: MediaQuery.of(context).viewInsets.bottom + 20,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            "Edit Profile",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 20),

          /// Avatar chooser
          SizedBox(
            height: 90,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: avatars.length,
              itemBuilder: (context, index) {
                final avatar = avatars[index];

                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedAvatar = avatar;
                    });
                  },
                  child: Container(
                    margin: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: selectedAvatar == avatar
                            ? Colors.blue
                            : Colors.transparent,
                        width: 3,
                      ),
                    ),
                    child: CircleAvatar(
                      radius: 35,
                      backgroundImage: AssetImage(avatar),
                    ),
                  ),
                );
              },
            ),
          ),

          const SizedBox(height: 20),

          /// Bio
          TextField(
            controller: bioController,
            maxLines: 3,
            decoration: const InputDecoration(
              labelText: "Bio",
              border: OutlineInputBorder(),
            ),
          ),

          const SizedBox(height: 20),

          ElevatedButton(
            onPressed: () async {
              final updated = widget.profile
                ..bio = bioController.text
                ..avatar = selectedAvatar;

              await ref.read(profileProvider.notifier).updateProfile(updated);

              context.pop();
            },
            child: const Text("Save"),
          ),
        ],
      ),
    );
  }
}
