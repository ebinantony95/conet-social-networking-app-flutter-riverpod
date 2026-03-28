import 'package:conet_app/features/authentication/data/auth_remote_datasource.dart';
import 'package:conet_app/features/chat/view model/chat_view_model.dart';
import 'package:conet_app/features/chat/view/provider/user_chat_provider.dart';
import 'package:conet_app/features/friends match/view model/firend_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class FriendsPage extends ConsumerStatefulWidget {
  const FriendsPage({super.key});

  @override
  ConsumerState<FriendsPage> createState() => _FriendsPageState();
}

class _FriendsPageState extends ConsumerState<FriendsPage> {
  String? currentUserId;

  @override
  void initState() {
    super.initState();
    _init();
  }

  Future<void> _init() async {
    final auth = AuthRemoteDatasource();
    final user = await auth.getCurrentUser();

    if (user != null) {
      setState(() {
        currentUserId = user.uid;
      });

      ref.read(friendsProvider.notifier).loadFriends(user.uid);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (currentUserId == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    final friends = ref.watch(friendsProvider);
    final chatsAsync = ref.watch(userChatsProvider(currentUserId!));

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: const Text("Friends")),

        body: chatsAsync.when(
          data: (chats) {
            /// SAFE CHAT MAP
            final chatMap = {
              for (var chat in chats)
                chat.participants.firstWhere(
                  (id) => id != currentUserId,
                  orElse: () => '',
                ): chat,
            };

            ///  COPY + SORT (
            final sortedFriends = [...friends];

            sortedFriends.sort((a, b) {
              final chatA = chatMap[a.uid];
              final chatB = chatMap[b.uid];

              final timeA = chatA?.lastTimestamp ?? DateTime(0);
              final timeB = chatB?.lastTimestamp ?? DateTime(0);

              return timeB.compareTo(timeA);
            });

            if (sortedFriends.isEmpty) {
              return const Center(child: Text("No friends yet"));
            }

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// 🔥 HEADER
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  child: Text(
                    "Recent Chats",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),

                ///  LIST
                Expanded(
                  child: ListView.builder(
                    itemCount: sortedFriends.length,
                    itemBuilder: (_, i) {
                      final user = sortedFriends[i];
                      final chat = chatMap[user.uid];

                      return Column(
                        children: [
                          ListTile(
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 6,
                            ),

                            ///  PROFILE
                            leading: CircleAvatar(
                              radius: 28,
                              backgroundImage: AssetImage(user.avatar),
                            ),

                            ///  NAME
                            title: Text(
                              user.name,
                              style: Theme.of(context).textTheme.titleMedium,
                            ),

                            /// LAST MESSAGE / FALLBACK
                            subtitle: Text(
                              chat?.lastMessage.isNotEmpty == true
                                  ? chat!.lastMessage
                                  : "Start a conversation",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),

                            ///  TIME + DOT
                            trailing: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  formatTime(chat?.lastTimestamp),
                                  style: const TextStyle(fontSize: 12),
                                ),
                                const SizedBox(height: 6),

                                ///  UNREAD INDICATOR (basic)
                                if (chat != null)
                                  Container(
                                    width: 8,
                                    height: 8,
                                    decoration: const BoxDecoration(
                                      color: Colors.green,
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                              ],
                            ),

                            ///  OPEN CHAT
                            onTap: () async {
                              final chatDatasource = ref.read(
                                chatDatasourceProvider,
                              );

                              final chatId = chatDatasource.getChatId(
                                currentUserId!,
                                user.uid,
                              );

                              await chatDatasource.createChat(
                                currentUserId!,
                                user.uid,
                              );

                              context.push(
                                '/chat',
                                extra: {
                                  'chatId': chatId,
                                  'currentUserId': currentUserId,
                                },
                              );
                            },
                          ),

                          const SizedBox(height: 6),
                        ],
                      );
                    },
                  ),
                ),
              ],
            );
          },

          loading: () => const Center(child: CircularProgressIndicator()),

          error: (e, _) => Center(child: Text("Error: $e")),
        ),
      ),
    );
  }
}

/// ⏰ TIME FORMATTER
String formatTime(DateTime? time) {
  if (time == null) return "";

  final now = DateTime.now();
  final diff = now.difference(time);

  if (diff.inMinutes < 1) {
    return "now";
  } else if (diff.inMinutes < 60) {
    return "${diff.inMinutes}m";
  } else if (diff.inHours < 24) {
    return "${diff.inHours}h";
  } else {
    return "${time.day}/${time.month}";
  }
}
