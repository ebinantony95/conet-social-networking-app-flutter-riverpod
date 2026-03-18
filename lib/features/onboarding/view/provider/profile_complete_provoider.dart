import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:conet_app/features/authentication/view/provider/auth_state_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final profileCompletedProvider = FutureProvider<bool>((ref) async {
  final user = ref.watch(authStateProvider).value;
  if (user == null) return false;

  final doc = await FirebaseFirestore.instance
      .collection("users")
      .doc(user.uid)
      .get();

  return doc.data()?["profileCompleted"] ?? false;
});
