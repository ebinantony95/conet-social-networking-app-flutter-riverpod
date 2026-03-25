import 'package:conet_app/features/match/data/match_remote_datasource.dart';

import 'package:flutter_riverpod/legacy.dart';
import '../../authentication/model/user_model.dart';

final matchProvider = StateNotifierProvider<MatchViewModel, List<UserModel>>((
  ref,
) {
  return MatchViewModel(MatchRemoteDatasource());
});

class MatchViewModel extends StateNotifier<List<UserModel>> {
  final MatchRemoteDatasource datasource;

  MatchViewModel(this.datasource) : super([]);

  late UserModel currentUser;

  /// LOAD USERS + FILTER
  Future<void> loadMatches(UserModel me) async {
    currentUser = me;

    final users = await datasource.fetchUsers();

    final filtered = users.where((user) {
      if (user.uid == me.uid) return false;

      final skillMatch = me.learning.any(
        (skill) => user.skills.contains(skill),
      );

      final interestMatch = me.interests.any((i) => user.interests.contains(i));

      return skillMatch || interestMatch;
    }).toList();

    state = filtered;
  }

  /// LIKE
  Future<UserModel?> like() async {
    if (state.isEmpty) return null;

    final user = state.first;

    final isMatch = await datasource.likeUser(currentUser.uid, user.uid);

    state = [...state]..removeAt(0);

    return isMatch ? user : null;
  }

  /// PASS
  Future<void> pass() async {
    if (state.isEmpty) return;

    final first = state.first;

    await datasource.passUser(currentUser.uid, first.uid);

    final updated = [...state];
    updated.removeAt(0);
    updated.add(first);

    state = updated;
  }
}
