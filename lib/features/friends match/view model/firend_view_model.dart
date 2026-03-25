import 'package:conet_app/features/authentication/model/user_model.dart';
import 'package:conet_app/features/match/data/match_remote_datasource.dart';
import 'package:flutter_riverpod/legacy.dart';

final friendsProvider =
    StateNotifierProvider<FriendsViewModel, List<UserModel>>((ref) {
      return FriendsViewModel(MatchRemoteDatasource());
    });

class FriendsViewModel extends StateNotifier<List<UserModel>> {
  final MatchRemoteDatasource datasource;

  FriendsViewModel(this.datasource) : super([]);

  Future<void> loadFriends(String myId) async {
    final users = await datasource.getMyMatches(myId);
    state = users;
  }
}
