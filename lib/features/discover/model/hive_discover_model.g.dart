// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hive_discover_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DiscoverUserHiveAdapter extends TypeAdapter<DiscoverUserHive> {
  @override
  final int typeId = 1;

  @override
  DiscoverUserHive read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DiscoverUserHive(
      id: fields[0] as String,
      name: fields[1] as String,
      avatar: fields[2] as String,
      interest: fields[3] as String,
      wantsToLearn: fields[4] as String,
    );
  }

  @override
  void write(BinaryWriter writer, DiscoverUserHive obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.avatar)
      ..writeByte(3)
      ..write(obj.interest)
      ..writeByte(4)
      ..write(obj.wantsToLearn);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DiscoverUserHiveAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
