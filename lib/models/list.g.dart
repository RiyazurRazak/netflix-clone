// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'list.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MYListAdapter extends TypeAdapter<MYList> {
  @override
  final int typeId = 0;

  @override
  MYList read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MYList(
      id: fields[0] as int,
      imageURL: fields[1] as String,
      title: fields[2] as String,
      ismovie: fields[3] as bool,
      overview: fields[4] as String,
      popularity: fields[5] as double,
    );
  }

  @override
  void write(BinaryWriter writer, MYList obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.imageURL)
      ..writeByte(2)
      ..write(obj.title)
      ..writeByte(3)
      ..write(obj.ismovie)
      ..writeByte(4)
      ..write(obj.overview)
      ..writeByte(5)
      ..write(obj.popularity);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MYListAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
