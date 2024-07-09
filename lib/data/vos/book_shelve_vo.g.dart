// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'book_shelve_vo.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ShelvesAdapter extends TypeAdapter<BookShelveVO> {
  @override
  final int typeId = 3;

  @override
  BookShelveVO read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return BookShelveVO(
      id: fields[0] as String?,
      shelveName: fields[1] as String?,
      bookCollectionList: (fields[2] as List?)?.cast<Books>(),
    );
  }

  @override
  void write(BinaryWriter writer, BookShelveVO obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.shelveName)
      ..writeByte(2)
      ..write(obj.bookCollectionList);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ShelvesAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
