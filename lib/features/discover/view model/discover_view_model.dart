import 'package:conet_app/features/discover/data/discovery_repository.dart';
import 'package:conet_app/features/discover/model/discover_user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

final discoverProvider =
    StateNotifierProvider<DiscoverViewModel, AsyncValue<List<DiscoverUser>>>((
      ref,
    ) {
      return DiscoverViewModel();
    });

class DiscoverViewModel extends StateNotifier<AsyncValue<List<DiscoverUser>>> {
  final repo = DiscoverRepository();

  DiscoverViewModel() : super(const AsyncLoading()) {
    loadUsers();
  }

  Future<void> loadUsers() async {
    final currentUserId = FirebaseAuth.instance.currentUser!.uid;

    /// ✅ Load cache first
    final cached = repo.getCachedUsers();
    if (cached.isNotEmpty) {
      state = AsyncData(cached);
    }

    try {
      /// ✅ Fetch fresh
      final fresh = await repo.fetchAndCache(currentUserId);
      state = AsyncData(fresh);
    } catch (e, st) {
      if (cached.isEmpty) {
        state = AsyncError(e, st);
      }
    }
  }

  /// ❌ Move card to bottom
  void moveToBottom(int index) {
    state.whenData((users) {
      final updated = [...users];
      final item = updated.removeAt(index);
      updated.add(item);
      state = AsyncData(updated);
    });
  }

  /// 🤝 Connect
  Future<void> connect(String userId) async {
    await repo.sendConnection(userId);
  }
}
