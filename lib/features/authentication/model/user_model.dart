class UserModel {
  final String uid;
  final String name;
  final String email;

  UserModel({required this.uid, required this.name, required this.email});

  // usermodel to map
  Map<String, dynamic> toMap() {
    return {"udi": uid, "name": name, "email": email};
  }

  // map to user model
  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(uid: map["uid"], name: map["name"], email: map["email"]);
  }
}
