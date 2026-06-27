// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hive_category.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HiveCategoryAdapter extends TypeAdapter<HiveCategory> {
  @override
  final int typeId = 1;

  @override
  HiveCategory read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HiveCategory(
      id: fields[0] as int,
      categoryKey: fields[1] as String,
      titleJson: fields[2] as String,
      color: fields[3] as String,
      isPremium: fields[4] as bool,
      groupId: fields[5] as String,
      imagePath: fields[6] as String?,
      lottiePath: fields[7] as String?,
      displayOrder: fields[8] as int,
      groupJson: fields[9] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, HiveCategory obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.categoryKey)
      ..writeByte(2)
      ..write(obj.titleJson)
      ..writeByte(3)
      ..write(obj.color)
      ..writeByte(4)
      ..write(obj.isPremium)
      ..writeByte(5)
      ..write(obj.groupId)
      ..writeByte(6)
      ..write(obj.imagePath)
      ..writeByte(7)
      ..write(obj.lottiePath)
      ..writeByte(8)
      ..write(obj.displayOrder)
      ..writeByte(9)
      ..write(obj.groupJson);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HiveCategoryAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
