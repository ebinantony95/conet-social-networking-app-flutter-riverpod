import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:conet_app/features/authentication/data/datasource/auth_remote_datasource.dart';
import 'package:conet_app/features/authentication/data/model/user_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

final authViewModelProvider =
    StateNotifierProvider<AuthViewModel, AsyncValue<void>>((ref) {
      return AuthViewModel(AuthRemoteDatasource());
    });

class AuthViewModel extends StateNotifier<AsyncValue<void>> {
  final AuthRemoteDatasource datasource;

  AuthViewModel(this.datasource) : super(const AsyncData(null));

  /// SIGNUP
  Future<void> signup({
    required String name,
    required String email,
    required String password,
    required List<String> interests,
    required List<String> skills,
    required List<String> learning,
  }) async {
    state = const AsyncLoading();

    try {
      final user = UserModel(
        uid: "",
        name: name,
        email: email,
        interests: interests,
        skills: skills,
        learning: learning,
        createdAt: Timestamp.now(),
      );

      await datasource.singUp(user, password);

      state = const AsyncData(null);
    } catch (e, stack) {
      state = AsyncError(e, stack);
    }
  }

  /// LOGIN
  Future<void> login({required String email, required String password}) async {
    state = const AsyncLoading();

    try {
      await datasource.login(email, password);

      state = const AsyncData(null);
    } catch (e, stack) {
      state = AsyncError(e, stack);
    }
  }

  /// LOGOUT
  Future<void> logout() async {
    try {
      await datasource.logout();
    } catch (e, stack) {
      state = AsyncError(e, stack);
    }
  }
}
