import 'package:conet_app/util/constant/images.dart';
import 'package:hive/hive.dart';

part 'profile_model.g.dart';

@HiveType(typeId: 0)
class UserProfile extends HiveObject {
  @HiveField(0)
  String uid;

  @HiveField(1)
  String bio;

  @HiveField(2)
  List<String> interests;

  @HiveField(3)
  List<String> skillsHave;

  @HiveField(4)
  List<String> skillsLearn;

  @HiveField(5)
  String name;

  @HiveField(6)
  String avatar;

  UserProfile({
    required this.uid,
    this.bio = "Tell people about yourself...",
    required this.interests,
    required this.skillsHave,
    required this.skillsLearn,
    required this.name,
    this.avatar = Appimages.defaultAvatar,
  });

  factory UserProfile.fromJson(Map<String, dynamic> json, String uid) {
    return UserProfile(
      uid: uid,
      bio: json["bio"] ?? "Tell people about yourself...",
      interests: List<String>.from(json["interests"] ?? []),
      skillsHave: List<String>.from(json["skills"] ?? []),
      skillsLearn: List<String>.from(json["learning"] ?? []),
      name: json["name"] ?? "",
      avatar: json["avatar"] ?? Appimages.defaultAvatar,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "bio": bio,
      "interests": interests,
      "skills": skillsHave,
      "learning": skillsLearn,
      "name": name,
      "avatar": avatar,
    };
  }
}
