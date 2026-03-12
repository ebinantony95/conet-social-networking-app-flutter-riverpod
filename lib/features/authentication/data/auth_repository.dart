import 'package:conet_app/util/exception/auth_exception.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthRepository {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // login.......
  Future<User?> login(String email, String password) async {
    try {
      final credential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      return credential.user;
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case "user-not-found":
          throw AuthException("User not found");

        case "wrong-password":
          throw AuthException("Wrong password");

        case "invalid-email":
          throw AuthException("Invalid email");

        default:
          throw AuthException("Authentication failed");
      }
    } catch (_) {
      throw AuthException("Something went wrong");
    }
  }

  /// signup........
  Future<User?> signup(String name, String email, String password) async {
    try {
      final credential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final user = credential.user;

      if (user != null) {
        await _firestore.collection("users").doc(user.uid).set({
          "uid": user.uid,
          "name": name,
          "email": email,
          "createdAt": FieldValue.serverTimestamp(),
        });
      }

      return user;
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case "email-already-in-use":
          throw AuthException("Email already registered");

        case "weak-password":
          throw AuthException("Password too weak");

        case "invalid-email":
          throw AuthException("Invalid email");

        default:
          throw AuthException("Signup failed");
      }
    } catch (_) {
      throw AuthException("Something went wrong");
    }
  }
}
