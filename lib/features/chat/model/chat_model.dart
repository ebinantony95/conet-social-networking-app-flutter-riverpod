class ChatModel {
  final String chatId;
  final List<String> participants;
  final String lastMessage;
  final DateTime? lastTimestamp;

  ChatModel({
    required this.chatId,
    required this.participants,
    required this.lastMessage,
    this.lastTimestamp,
  });

  factory ChatModel.fromMap(String id, Map<String, dynamic> map) {
    return ChatModel(
      chatId: id,
      participants: List<String>.from(map['participants'] ?? []),
      lastMessage: map['lastMessage'] ?? '',
      lastTimestamp: map['lastTimestamp'] != null
          ? map['lastTimestamp'].toDate()
          : null,
    );
  }
}
