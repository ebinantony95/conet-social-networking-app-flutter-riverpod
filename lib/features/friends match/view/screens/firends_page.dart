import 'package:conet_app/features/authentication/data/auth_remote_datasource.dart';
import 'package:conet_app/features/friends%20match/view%20model/firend_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FriendsPage extends ConsumerStatefulWidget {
  const FriendsPage({super.key});

  @override
  ConsumerState<FriendsPage> createState() => _FriendsPageState();
}

class _FriendsPageState extends ConsumerState<FriendsPage> {
  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final auth = AuthRemoteDatasource();
    final user = await auth.getCurrentUser();

    if (user != null) {
      ref.read(friendsProvider.notifier).loadFriends(user.uid);
    }
  }

  @override
  Widget build(BuildContext context) {
    final friends = ref.watch(friendsProvider);

    if (friends.isEmpty) {
      return const Scaffold(body: Center(child: Text("No friends yet")));
    }

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: const Text("Friends")),
        body: Padding(
          padding: const EdgeInsets.all(10),
          child: ListView.builder(
            itemCount: friends.length,
            itemBuilder: (_, i) {
              final user = friends[i];

              return Column(
                children: [
                  ListTile(
                    leading: CircleAvatar(
                      radius: 30,
                      backgroundImage: AssetImage(user.avatar),
                    ),
                    title: Text(
                      user.name,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    subtitle: Text(user.bio),
                    onTap: () {
                      // 👉 open chat later
                    },
                  ),
                  SizedBox(height: 10),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
