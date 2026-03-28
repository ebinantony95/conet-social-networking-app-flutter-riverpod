import 'package:conet_app/features/post/view%20model/post_view_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final matchCountProvider = StreamProvider.family<int, String>((ref, userId) {
  final vm = ref.read(
    postViewModelProvider.notifier,
  ); // or create separate MatchViewModel
  return vm.getMatchCount(userId);
});
