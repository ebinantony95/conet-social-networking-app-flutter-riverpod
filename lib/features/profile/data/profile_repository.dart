import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:conet_app/features/profile/model/profile_model.dart';
import 'package:hive/hive.dart';

class ProfileRepository {
  final firestore = FirebaseFirestore.instance;

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

  // for updating the bio
  Future<void> updateBio(String uid, String bio) async {
    final box = Hive.box<UserProfile>("profileBox");

    final profile = box.get(uid);

    if (profile != null) {
      profile.bio = bio;
      await profile.save();
    }

    await firestore.collection("users").doc(uid).update({"bio": bio});
  }
}
