import 'package:hive/hive.dart';

part 'hive_group.g.dart';

/// Hive-stored representation of a GroupModel.
@HiveType(typeId: 2)
class HiveGroup extends HiveObject {
  @HiveField(0)
  String id;

  /// JSON string: {"en":"...","gu":"...","hi":"..."}
  @HiveField(1)
  String nameJson;

  @HiveField(2)
  String icon;

  @HiveField(3)
  int displayOrder;

  HiveGroup({
    required this.id,
    required this.nameJson,
    required this.icon,
    required this.displayOrder,
  });
}
