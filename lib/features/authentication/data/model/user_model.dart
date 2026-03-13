import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String uid;
  final String email;
  final String name;
  final List<String> interests;
  final List<String> skillsToTeach;
  final List<String> skillsToLearn;
  final Timestamp createdAt;

  UserModel({
    required this.uid,
    required this.email,
    required this.name,
    required this.interests,
    required this.skillsToTeach,
    required this.skillsToLearn,
    required this.createdAt,
  });

  // convert model to map for firestore
  Map<String, dynamic> toMap() {
    return {
      "uid": uid,
      "name": name,
      "email": email,
      "interests": interests,
      "skillsToTeach": skillsToTeach,
      "skillsToLearn": skillsToLearn,
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
      skillsToTeach: List<String>.from(map['skillsToTeach'] ?? []),
      skillsToLearn: List<String>.from(map['skillsToLearn'] ?? []),
      createdAt: map['createdAt'] ?? Timestamp.now(),
    );
  }

  /// copyWith
  UserModel copyWith({
    String? uid,
    String? name,
    String? email,
    List<String>? interests,
    List<String>? skillsToTeach,
    List<String>? skillsToLearn,
    Timestamp? createdAt,
  }) {
    return UserModel(
      uid: uid ?? this.uid,
      name: name ?? this.name,
      email: email ?? this.email,
      interests: interests ?? this.interests,
      skillsToTeach: skillsToTeach ?? this.skillsToTeach,
      skillsToLearn: skillsToLearn ?? this.skillsToLearn,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
