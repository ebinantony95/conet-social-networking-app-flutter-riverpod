import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:conet_app/features/profile/model/profile_model.dart';
import 'package:hive/hive.dart';

class ProfileRepository {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> updateProfile(UserProfile profile) async {
    /// Update Firestore
    await firestore.collection("users").doc(profile.uid).update({
      "bio": profile.bio,
      "avatar": profile.avatar,
    });

    /// Update Local Hive Cache
    final box = Hive.box<UserProfile>("profileBox");
    await box.put(profile.uid, profile);
  }
}
