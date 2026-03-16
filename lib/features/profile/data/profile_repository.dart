import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:conet_app/features/profile/model/profile_model.dart';
import 'package:hive/hive.dart';

class ProfileRepository {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  /// Get profile (Hive cache → Firestore fallback)
  Future<UserProfile?> getProfile(String uid) async {
    final box = Hive.box<UserProfile>("profileBox");

    final localProfile = box.get(uid);

    if (localProfile != null) {
      return localProfile;
    }

    final doc = await firestore.collection("users").doc(uid).get();

    if (!doc.exists) return null;

    final profile = UserProfile.fromJson(doc.data()!, uid);

    await box.put(uid, profile);

    return profile;
  }

  /// Update profile (bio + avatar)
  Future<void> updateProfile(UserProfile profile) async {
    final box = Hive.box<UserProfile>("profileBox");

    /// update hive
    await box.put(profile.uid, profile);

    /// update firestore
    await firestore.collection("users").doc(profile.uid).update({
      "bio": profile.bio,
      "avatar": profile.avatar,
    });
  }
}
