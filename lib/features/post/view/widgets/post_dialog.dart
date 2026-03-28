import 'package:conet_app/features/post/view%20model/post_view_model.dart';
import 'package:conet_app/features/post/view/provider/current_user_provider.dart';
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
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _createPost(String text) async {
    setState(() => isLoading = true);

    final user = await ref.read(currentUserProvider.future);

    if (user == null) {
      setState(() => isLoading = false);
      return;
    }

    try {
      await ref
          .read(postViewModelProvider.notifier)
          .createPost(
            userId: user.uid,
            userName: user.name,
            userAvatar: user.avatar,
            content: text,
          );

      if (mounted) Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Failed to post")));
    }

    if (mounted) setState(() => isLoading = false);
  }

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

            /// 🔹 BUTTONS
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                /// CANCEL
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text("Cancel"),
                ),

                /// POST BUTTON (REACTIVE)
                ValueListenableBuilder(
                  valueListenable: _controller,
                  builder: (context, TextEditingValue value, _) {
                    final isEmpty = value.text.trim().isEmpty;

                    return ElevatedButton(
                      onPressed: isLoading || isEmpty
                          ? null
                          : () => _createPost(value.text.trim()),
                      child: isLoading
                          ? const SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            )
                          : const Text("Post"),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
