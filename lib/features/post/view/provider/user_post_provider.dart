import 'package:conet_app/features/post/model/post_model.dart';
import 'package:conet_app/features/post/view%20model/post_view_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final userPostsProvider = StreamProvider.family<List<PostModel>, String>((
  ref,
  userId,
) {
  final vm = ref.watch(postViewModelProvider.notifier);
  return vm.getUserPosts(userId);
});
