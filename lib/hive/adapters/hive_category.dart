import 'package:hive/hive.dart';

part 'hive_category.g.dart';

/// Hive-stored representation of a CategoryModel.
/// The [groupJson] field stores the embedded GroupModel as a JSON string.
@HiveType(typeId: 1)
class HiveCategory extends HiveObject {
  @HiveField(0)
  int id;

  @HiveField(1)
  String categoryKey;

  /// JSON string: {"en":"...","gu":"...","hi":"..."}
  @HiveField(2)
  String titleJson;

  @HiveField(3)
  String color;

  @HiveField(4)
  bool isPremium;

  @HiveField(5)
  String groupId;

  @HiveField(6)
  String? imagePath;

  @HiveField(7)
  String? lottiePath;

  @HiveField(8)
  int displayOrder;

  /// JSON string of the embedded GroupModel, or null if not joined.
  @HiveField(9)
  String? groupJson;

  HiveCategory({
    required this.id,
    required this.categoryKey,
    required this.titleJson,
    required this.color,
    required this.isPremium,
    required this.groupId,
    this.imagePath,
    this.lottiePath,
    required this.displayOrder,
    this.groupJson,
  });
}
