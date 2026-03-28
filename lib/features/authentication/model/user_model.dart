import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String uid;
  final String email;
  final String name;
  final String bio;
  final String avatar;
  final List<String> interests;
  final List<String> skills;
  final List<String> learning;

  final Timestamp createdAt;

  UserModel({
    required this.uid,
    required this.email,
    required this.name,
    required this.bio,
    required this.avatar,
    required this.interests,
    required this.skills,
    required this.learning,
    required this.createdAt,
  });

  // convert model to map for firestore
  Map<String, dynamic> toMap() {
    return {
      "uid": uid,
      "name": name,
      "email": email,
      "bio": bio,
      "avatar": avatar,
      "interests": interests,
      "skills": skills,
      "learning": learning,
      "createdAt": createdAt,
    };
  }

  // convert map to model
  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'] ?? '',
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      bio: map['bio'] ?? 'Tell people about yourself...',
      avatar: map['avatar'] ?? 'assets/avatars/default.png',
      interests: List<String>.from(map['interests'] ?? []),
      skills: List<String>.from(map['skills'] ?? []),
      learning: List<String>.from(map['learning'] ?? []),
      createdAt: map['createdAt'] ?? Timestamp.now(),
    );
  }

  /// copyWith
  UserModel copyWith({
    String? uid,
    String? name,
    String? email,
    String? bio,
    String? avatar,
    List<String>? interests,
    List<String>? skills,
    List<String>? learning,
    Timestamp? createdAt,
  }) {
    return UserModel(
      uid: uid ?? this.uid,
      name: name ?? this.name,
      email: email ?? this.email,
      bio: bio ?? this.bio,
      avatar: avatar ?? this.avatar,
      interests: interests ?? this.interests,
      skills: skills ?? this.skills,
      learning: learning ?? this.learning,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
