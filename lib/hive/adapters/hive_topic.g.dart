// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hive_topic.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HiveTopicAdapter extends TypeAdapter<HiveTopic> {
  @override
  final int typeId = 3;

  @override
  HiveTopic read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HiveTopic(
      id: fields[0] as int,
      topicKey: fields[1] as String,
      categoryId: fields[2] as int,
      nameJson: fields[3] as String,
      svgPath: fields[4] as String?,
      imagePath: fields[5] as String?,
      lottiePath: fields[6] as String?,
      narrationJson: fields[7] as String,
      explanationJson: fields[8] as String,
      factJson: fields[9] as String,
      gameType: fields[10] as String,
      isFree: fields[11] as bool,
      displayOrder: fields[12] as int,
    );
  }

  @override
  void write(BinaryWriter writer, HiveTopic obj) {
    writer
      ..writeByte(13)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.topicKey)
      ..writeByte(2)
      ..write(obj.categoryId)
      ..writeByte(3)
      ..write(obj.nameJson)
      ..writeByte(4)
      ..write(obj.svgPath)
      ..writeByte(5)
      ..write(obj.imagePath)
      ..writeByte(6)
      ..write(obj.lottiePath)
      ..writeByte(7)
      ..write(obj.narrationJson)
      ..writeByte(8)
      ..write(obj.explanationJson)
      ..writeByte(9)
      ..write(obj.factJson)
      ..writeByte(10)
      ..write(obj.gameType)
      ..writeByte(11)
      ..write(obj.isFree)
      ..writeByte(12)
      ..write(obj.displayOrder);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HiveTopicAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
