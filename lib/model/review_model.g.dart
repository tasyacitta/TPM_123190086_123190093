// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'review_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ReviewModelAdapter extends TypeAdapter<ReviewModel> {
  @override
  final int typeId = 2;

  @override
  ReviewModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ReviewModel(
      id: fields[0] as int,
      id_user: fields[1] as int,
      id_product: fields[2] as int,
      username: fields[3] as String,
      review: fields[4] as String,
      usage_period: fields[5] as String,
      skin_type: fields[6] as String,
    );
  }

  @override
  void write(BinaryWriter writer, ReviewModel obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.id_user)
      ..writeByte(2)
      ..write(obj.id_product)
      ..writeByte(3)
      ..write(obj.username)
      ..writeByte(4)
      ..write(obj.review)
      ..writeByte(5)
      ..write(obj.usage_period)
      ..writeByte(6)
      ..write(obj.skin_type);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ReviewModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
