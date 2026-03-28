import 'package:conet_app/features/authentication/model/user_model.dart';
import 'package:conet_app/features/chat/model/chat_model.dart';
import 'package:conet_app/features/chat/model/message_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import '../data/chat_remote_datasource.dart';

final chatDatasourceProvider = Provider((ref) => ChatRemoteDatasource());

final chatViewModelProvider =
    StateNotifierProvider<ChatViewModel, AsyncValue<void>>(
      (ref) => ChatViewModel(ref),
    );

class ChatViewModel extends StateNotifier<AsyncValue<void>> {
  final Ref ref;

  ChatViewModel(this.ref) : super(const AsyncData(null));

  Future<void> sendMessage({
    required String chatId,
    required String senderId,
    required String text,
  }) async {
    try {
      state = const AsyncLoading();

      final message = MessageModel(
        id: '',
        senderId: senderId,
        text: text,
        timestamp: DateTime.now(),
      );

      await ref
          .read(chatDatasourceProvider)
          .sendMessage(chatId: chatId, message: message);

      state = const AsyncData(null);
    } catch (e) {
      state = AsyncError(e, StackTrace.current);
    }
  }

  Stream<List<MessageModel>> getMessages(String chatId) {
    return ref.read(chatDatasourceProvider).getMessages(chatId);
  }

  Stream<ChatModel> getChat(String chatId) {
    return ref.read(chatDatasourceProvider).getChat(chatId);
  }

  Stream<UserModel> getUser(String uid) {
    return ref.read(chatDatasourceProvider).getUser(uid);
  }
}
