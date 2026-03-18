import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:conet_app/features/authentication/model/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthRemoteDatasource {
  // create instance of firebase&firestore
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // CREATE ACC

  Future<void> singUp(UserModel user, String password) async {
    try {
      final credential = await _auth.createUserWithEmailAndPassword(
        email: user.email,
        password: password,
      );
      // to get the uid to create collection
      final uid = credential.user!.uid;

      /// add uid to model
      final newUser = user.copyWith(uid: uid);

      // create a collection
      await _firestore.collection("users").doc(uid).set(newUser.toMap());

      //exception handle
    } on FirebaseAuthException catch (e) {
      throw Exception(_handleAuthError(e));
    } catch (e) {
      throw Exception("Something went wrong");
    }
  }

  // LOGIN

  Future<void> login(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      throw Exception(_handleAuthError(e));
    } catch (e) {
      throw Exception("Login failed");
    }
  }

  //LOGOUT

  Future<void> logout() async {
    await _auth.signOut();
  }
}

/// AUTH ERROR HANDLER
String _handleAuthError(FirebaseAuthException e) {
  switch (e.code) {
    case "email-already-in-use":
      return "Email already registered";

    case "invalid-email":
      return "Invalid email address";

    case "weak-password":
      return "Password is too weak";

    case "user-not-found":
      return "User not found";

    case "wrong-password":
      return "Incorrect password";

    default:
      return "Authentication error";
  }
}
