import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:conet_app/features/authentication/model/user_model.dart';
import 'package:conet_app/features/chat/model/chat_model.dart';
import 'package:conet_app/features/chat/model/message_model.dart';

class ChatRemoteDatasource {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  String getChatId(String u1, String u2) {
    return u1.hashCode <= u2.hashCode ? '${u1}_$u2' : '${u2}_$u1';
  }

  Future<void> createChat(String user1, String user2) async {
    final chatId = getChatId(user1, user2);

    await _firestore.collection('chats').doc(chatId).set({
      'participants': [user1, user2],
      'lastMessage': '',
      'lastTimestamp': FieldValue.serverTimestamp(),
    });
  }

  Future<void> sendMessage({
    required String chatId,
    required MessageModel message,
  }) async {
    final ref = _firestore
        .collection('chats')
        .doc(chatId)
        .collection('messages');

    await ref.add(message.toMap());

    await _firestore.collection('chats').doc(chatId).update({
      'lastMessage': message.text,
      'lastTimestamp': FieldValue.serverTimestamp(),
    });
  }

  Stream<List<MessageModel>> getMessages(String chatId) {
    return _firestore
        .collection('chats')
        .doc(chatId)
        .collection('messages')
        .orderBy('timestamp')
        .snapshots()
        .map((snapshot) {
          return snapshot.docs.map((doc) {
            return MessageModel.fromMap(doc.id, doc.data());
          }).toList();
        });
  }

  Stream<List<ChatModel>> getUserChats(String userId) {
    return _firestore
        .collection('chats')
        .where('participants', arrayContains: userId)
        .orderBy('lastTimestamp', descending: true)
        .snapshots()
        .map((snapshot) {
          return snapshot.docs.map((doc) {
            return ChatModel.fromMap(doc.id, doc.data());
          }).toList();
        });
  }

  Stream<ChatModel> getChat(String chatId) {
    return _firestore
        .collection('chats')
        .doc(chatId)
        .snapshots()
        .map((doc) => ChatModel.fromMap(doc.id, doc.data()!));
  }

  Stream<UserModel> getUser(String uid) {
    return _firestore
        .collection('users')
        .doc(uid)
        .snapshots()
        .map((doc) => UserModel.fromMap(doc.data()!));
  }
}
