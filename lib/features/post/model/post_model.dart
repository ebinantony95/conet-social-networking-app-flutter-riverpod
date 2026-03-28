import 'package:cloud_firestore/cloud_firestore.dart';

class PostModel {
  final String id;
  final String userId;
  final String userName;
  final String avatar;
  final String content;
  final Timestamp createdAt;
  final int likesCount;

  PostModel({
    required this.id,
    required this.userId,
    required this.userName,
    required this.avatar,
    required this.content,
    required this.createdAt,
    required this.likesCount,
  });

  factory PostModel.fromMap(Map<String, dynamic> map, String docId) {
    return PostModel(
      id: docId,
      userId: map['userId'] ?? '',
      userName: map['userName'] ?? '',
      avatar: map['avatar'] ?? 'assets/avatars/default_image.png',
      content: map['content'] ?? '',
      createdAt: map['createdAt'] ?? Timestamp.now(),
      likesCount: map['likesCount'] ?? 0,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'userName': userName,
      'avatar': avatar,
      'content': content,
      'createdAt': createdAt,
      'likesCount': likesCount,
    };
  }
}
