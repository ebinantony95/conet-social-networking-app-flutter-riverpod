import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:conet_app/features/post/view/provider/current_user_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final friendsCountProvider = StreamProvider<int>((ref) {
  final userId = ref.watch(currentUserProvider).value!.uid;

  return FirebaseFirestore.instance
      .collection('users')
      .doc(userId)
      .collection('friends')
      .snapshots()
      .map((snap) => snap.docs.length);
});
