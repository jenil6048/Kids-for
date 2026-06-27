import 'package:hive/hive.dart';

part 'config_entry.g.dart';

@HiveType(typeId: 0)
class ConfigEntry extends HiveObject {
  @HiveField(0)
  String categoryKey;

  @HiveField(1)
  int version;

  @HiveField(2)
  String updatedAt;

  ConfigEntry({
    required this.categoryKey,
    required this.version,
    required this.updatedAt,
  });
}
