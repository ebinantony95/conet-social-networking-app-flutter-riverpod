import 'package:conet_app/features/chat/model/chat_model.dart';
import 'package:conet_app/features/chat/view%20model/chat_view_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final userChatsProvider = StreamProvider.family<List<ChatModel>, String>((
  ref,
  userId,
) {
  return ref.read(chatDatasourceProvider).getUserChats(userId);
});
