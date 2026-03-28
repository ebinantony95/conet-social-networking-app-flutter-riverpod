import 'package:conet_app/features/post/model/view%20model/post_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CreatePostDialog extends ConsumerStatefulWidget {
  const CreatePostDialog({super.key});

  @override
  ConsumerState<CreatePostDialog> createState() => _CreatePostDialogState();
}

class _CreatePostDialogState extends ConsumerState<CreatePostDialog> {
  final TextEditingController _controller = TextEditingController();

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            /// 🔹 TITLE
            const Text(
              "Create Post",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 12),

            /// 🔹 INPUT FIELD
            TextField(
              controller: _controller,
              maxLines: 4,
              decoration: InputDecoration(
                hintText: "What's on your mind?",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),

            const SizedBox(height: 16),

            /// 🔹 ACTION BUTTONS
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text("Cancel"),
                ),

                ElevatedButton(
                  onPressed: isLoading
                      ? null
                      : () async {
                          if (_controller.text.trim().isEmpty) return;

                          setState(() => isLoading = true);

                          await ref
                              .read(postViewModelProvider.notifier)
                              .createPost(
                                userId: "123", // replace
                                userName: "Ebin", // replace
                                userAvatar: "https://your-image-url",
                                content: _controller.text.trim(),
                              );

                          setState(() => isLoading = false);

                          Navigator.pop(context);
                        },
                  child: isLoading
                      ? const CircularProgressIndicator()
                      : const Text("Post"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
