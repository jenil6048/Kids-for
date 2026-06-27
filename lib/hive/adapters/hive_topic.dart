import 'package:hive/hive.dart';

part 'hive_topic.g.dart';

/// Hive-stored representation of a TopicModel.
/// All LocalizedText fields are stored as JSON strings to avoid nested adapters.
@HiveType(typeId: 3)
class HiveTopic extends HiveObject {
  @HiveField(0)
  int id;

  @HiveField(1)
  String topicKey;

  @HiveField(2)
  int categoryId;

  /// JSON: {"en":"...","gu":"...","hi":"..."}
  @HiveField(3)
  String nameJson;

  @HiveField(4)
  String? svgPath;

  @HiveField(5)
  String? imagePath;

  @HiveField(6)
  String? lottiePath;

  /// JSON: {"en":"...","gu":"...","hi":"..."}
  @HiveField(7)
  String narrationJson;

  /// JSON: {"en":"...","gu":"...","hi":"..."}
  @HiveField(8)
  String explanationJson;

  /// JSON: {"en":"...","gu":"...","hi":"..."}
  @HiveField(9)
  String factJson;

  @HiveField(10)
  String gameType;

  @HiveField(11)
  bool isFree;

  @HiveField(12)
  int displayOrder;

  HiveTopic({
    required this.id,
    required this.topicKey,
    required this.categoryId,
    required this.nameJson,
    this.svgPath,
    this.imagePath,
    this.lottiePath,
    required this.narrationJson,
    required this.explanationJson,
    required this.factJson,
    required this.gameType,
    required this.isFree,
    required this.displayOrder,
  });
}
