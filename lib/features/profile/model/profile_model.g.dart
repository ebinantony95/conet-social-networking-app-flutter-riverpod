// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserProfileAdapter extends TypeAdapter<UserProfile> {
  @override
  final int typeId = 0;

  @override
  UserProfile read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserProfile(
      uid: fields[0] as String,
      bio: fields[1] as String,
      interests: (fields[2] as List).cast<String>(),
      skillsHave: (fields[3] as List).cast<String>(),
      skillsLearn: (fields[4] as List).cast<String>(),
      name: fields[5] as String,
    );
  }

  @override
  void write(BinaryWriter writer, UserProfile obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.uid)
      ..writeByte(1)
      ..write(obj.bio)
      ..writeByte(2)
      ..write(obj.interests)
      ..writeByte(3)
      ..write(obj.skillsHave)
      ..writeByte(4)
      ..write(obj.skillsLearn)
      ..writeByte(5)
      ..write(obj.name);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserProfileAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
