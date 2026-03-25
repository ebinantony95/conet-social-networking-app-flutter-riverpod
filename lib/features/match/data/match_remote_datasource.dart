import 'package:cloud_firestore/cloud_firestore.dart';
import '../../authentication/model/user_model.dart';

class MatchRemoteDatasource {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// GET ALL USERS
  Future<List<UserModel>> fetchUsers() async {
    final snapshot = await _firestore.collection("users").get();

    return snapshot.docs.map((doc) => UserModel.fromMap(doc.data())).toList();
  }

  /// LIKE USER
  Future<bool> likeUser(String myId, String otherId) async {
    final likeRef = _firestore
        .collection("likes")
        .doc(myId)
        .collection("userLikes")
        .doc(otherId);

    await likeRef.set({"likedAt": FieldValue.serverTimestamp()});

    /// check reverse like
    final reverse = await _firestore
        .collection("likes")
        .doc(otherId)
        .collection("userLikes")
        .doc(myId)
        .get();

    if (reverse.exists) {
      await createMatch(myId, otherId);
      return true; // MATCH 🎉
    }

    return false;
  }

  /// PASS USER
  Future<void> passUser(String myId, String otherId) async {
    await _firestore
        .collection("passes")
        .doc(myId)
        .collection("userPasses")
        .doc(otherId)
        .set({"passedAt": FieldValue.serverTimestamp()});
  }

  /// CREATE MATCH
  Future<void> createMatch(String uid1, String uid2) async {
    final ids = [uid1, uid2]..sort();

    await _firestore.collection("matches").doc(ids.join("_")).set({
      "users": ids,
      "createdAt": FieldValue.serverTimestamp(),
    });
  }

  Future<List<UserModel>> getMyMatches(String myId) async {
    final snapshot = await _firestore
        .collection("matches")
        .where("users", arrayContains: myId)
        .get();

    List<UserModel> friends = [];

    for (var doc in snapshot.docs) {
      final users = List<String>.from(doc["users"]);

      /// get other user id
      final otherId = users.firstWhere((id) => id != myId);

      final userDoc = await _firestore.collection("users").doc(otherId).get();

      if (userDoc.exists) {
        friends.add(UserModel.fromMap(userDoc.data()!));
      }
    }

    return friends;
  }
}
