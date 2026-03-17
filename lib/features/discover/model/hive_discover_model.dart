import 'package:hive/hive.dart';

part 'hive_discover_model.g.dart';

@HiveType(typeId: 1)
class DiscoverUserHive extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  String name;

  @HiveField(2)
  String avatar;

  @HiveField(3)
  String interest;

  @HiveField(4)
  String wantsToLearn;

  DiscoverUserHive({
    required this.id,
    required this.name,
    required this.avatar,
    required this.interest,
    required this.wantsToLearn,
  });
}
