// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pokemon_detail.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PokemonDetailAdapter extends TypeAdapter<PokemonDetail> {
  @override
  final int typeId = 1;

  @override
  PokemonDetail read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PokemonDetail(
      descriptions: (fields[0] as List).cast<String>(),
      height: fields[1] as String?,
      category: fields[2] as String?,
      genders: (fields[3] as List).cast<String>(),
      weight: fields[4] as String?,
      character: fields[5] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, PokemonDetail obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.descriptions)
      ..writeByte(1)
      ..write(obj.height)
      ..writeByte(2)
      ..write(obj.category)
      ..writeByte(3)
      ..write(obj.genders)
      ..writeByte(4)
      ..write(obj.weight)
      ..writeByte(5)
      ..write(obj.character);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PokemonDetailAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
