import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:conet_app/features/discover/model/discover_user_model.dart';
import 'package:conet_app/features/discover/model/hive_discover_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hive/hive.dart';

class DiscoverRepository {
  final firestore = FirebaseFirestore.instance;
  final box = Hive.box<DiscoverUserHive>('discoverBox');

  /// 🔹 Load cached users
  List<DiscoverUser> getCachedUsers() {
    return box.values.map((e) {
      return DiscoverUser(
        id: e.id,
        name: e.name,
        avatar: e.avatar,
        interest: e.interest,
        wantsToLearn: e.wantsToLearn,
      );
    }).toList();
  }

  /// 🔹 Fetch from Firestore + cache
  Future<List<DiscoverUser>> fetchAndCache(String currentUserId) async {
    final snapshot = await firestore.collection('users').get();

    final users = snapshot.docs
        .where(
          (doc) =>
              doc.id != currentUserId &&
              (doc.data()['profileCompleted'] ?? false),
        )
        .map((doc) => DiscoverUser.fromFirestore(doc.data(), doc.id))
        .toList();

    /// Save to Hive
    await box.clear();
    for (var user in users) {
      await box.put(
        user.id,
        DiscoverUserHive(
          id: user.id,
          name: user.name,
          avatar: user.avatar,
          interest: user.interest,
          wantsToLearn: user.wantsToLearn,
        ),
      );
    }

    return users;
  }

  /// 🔹 Send connection request
  Future<void> sendConnection(String targetUserId) async {
    final currentUserId = FirebaseAuth.instance.currentUser!.uid;

    final docId = "${currentUserId}_$targetUserId";

    final existing = await firestore.collection('connections').doc(docId).get();

    if (existing.exists) return;

    await firestore.collection('connections').doc(docId).set({
      'from': currentUserId,
      'to': targetUserId,
      'status': 'pending',
      'createdAt': FieldValue.serverTimestamp(),
    });
  }
}
