// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'config_entry.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ConfigEntryAdapter extends TypeAdapter<ConfigEntry> {
  @override
  final int typeId = 0;

  @override
  ConfigEntry read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ConfigEntry(
      categoryKey: fields[0] as String,
      version: fields[1] as int,
      updatedAt: fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, ConfigEntry obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.categoryKey)
      ..writeByte(1)
      ..write(obj.version)
      ..writeByte(2)
      ..write(obj.updatedAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ConfigEntryAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
