import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthRemoteDataSource {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  /// LOGIN
  Future<UserCredential> login({
    required String email,
    required String password,
  }) async {
    return await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  /// SIGN UP

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Future<UserCredential> signup({
    required String email,
    required String password,
    required String name,
  }) async {
    /// Create auth account
    final userCredential = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    final uid = userCredential.user!.uid;

    /// Create user document
    await _firestore.collection("users").doc(uid).set({
      "name": name,
      "email": email,
      "createdAt": FieldValue.serverTimestamp(),
      "skillsHave": [],
      "skillsWant": [],
      "interests": [],
    });

    return userCredential;
  }

  /// LOGOUT
  Future<void> logout() async {
    await _auth.signOut();
  }

  /// CURRENT USER
  User? getCurrentUser() {
    return _auth.currentUser;
  }
}
