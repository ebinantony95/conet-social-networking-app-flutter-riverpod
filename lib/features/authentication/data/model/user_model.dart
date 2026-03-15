import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String uid;
  final String email;
  final String name;
  final List<String> interests;
  final List<String> skills;
  final List<String> learning;
  final Timestamp createdAt;

  UserModel({
    required this.uid,
    required this.email,
    required this.name,
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
    List<String>? interests,
    List<String>? skills,
    List<String>? learning,
    Timestamp? createdAt,
  }) {
    return UserModel(
      uid: uid ?? this.uid,
      name: name ?? this.name,
      email: email ?? this.email,
      interests: interests ?? this.interests,
      skills: skills ?? this.skills,
      learning: learning ?? this.learning,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
