import 'package:conet_app/features/profile/model/profile_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import '../data/profile_repository.dart';

final profileRepositoryProvider = Provider((ref) {
  return ProfileRepository();
});

final profileProvider =
    StateNotifierProvider<ProfileViewModel, AsyncValue<UserProfile?>>((ref) {
      final repo = ref.watch(profileRepositoryProvider);

      return ProfileViewModel(repo);
    });

class ProfileViewModel extends StateNotifier<AsyncValue<UserProfile?>> {
  final ProfileRepository repository;

  ProfileViewModel(this.repository) : super(const AsyncLoading());

  Future<void> loadProfile(String uid) async {
    state = const AsyncLoading();

    try {
      final profile = await repository.getProfile(uid);

      state = AsyncData(profile);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }

  Future<void> updateBio(String uid, String bio) async {
    await repository.updateBio(uid, bio);

    if (state.value != null) {
      state = AsyncData(state.value!..bio = bio);
    }
  }
}
