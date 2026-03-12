import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import '../data/auth_repository.dart';

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepository();
});

final authViewModelProvider =
    StateNotifierProvider<AuthViewModel, AsyncValue<void>>((ref) {
      final repo = ref.read(authRepositoryProvider);

      return AuthViewModel(repo);
    });

class AuthViewModel extends StateNotifier<AsyncValue<void>> {
  final AuthRepository repo;

  AuthViewModel(this.repo) : super(const AsyncData(null));

  Future<void> login(String email, String password) async {
    state = const AsyncLoading();

    try {
      await repo.login(email, password);

      state = const AsyncData(null);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }

  Future<void> signup(String name, String email, String password) async {
    state = const AsyncLoading();

    try {
      await repo.signup(name, email, password);

      state = const AsyncData(null);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }
}
