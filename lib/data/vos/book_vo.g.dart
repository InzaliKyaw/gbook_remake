// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'book_vo.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BooksVOAdapter extends TypeAdapter<Books> {
  @override
  final int typeId = 1;

  @override
  Books read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Books(
      fields[0] as String?,
      fields[1] as String?,
      fields[2] as String?,
      fields[3] as String?,
      fields[4] as String?,
      fields[5] as int?,
      fields[6] as int?,
      fields[7] as String?,
      fields[8] as String?,
      fields[9] as String?,
      fields[10] as String?,
      fields[11] as String?,
      fields[12] as String?,
      fields[13] as String?,
      fields[14] as String?,
      fields[15] as String?,
      fields[16] as String?,
      fields[17] as String?,
      fields[18] as int?,
      fields[19] as int?,
      fields[20] as String?,
      fields[21] as String?,
      fields[22] as String?,
      fields[23] as int?,
      (fields[24] as List?)?.cast<BuyLinks>(),
    );
  }

  @override
  void write(BinaryWriter writer, Books obj) {
    writer
      ..writeByte(25)
      ..writeByte(0)
      ..write(obj.ageGroup)
      ..writeByte(1)
      ..write(obj.amazonProductUrl)
      ..writeByte(2)
      ..write(obj.articleChapterLink)
      ..writeByte(3)
      ..write(obj.author)
      ..writeByte(4)
      ..write(obj.bookImage)
      ..writeByte(5)
      ..write(obj.bookImageWidth)
      ..writeByte(6)
      ..write(obj.bookImageHeight)
      ..writeByte(7)
      ..write(obj.bookReviewLink)
      ..writeByte(8)
      ..write(obj.contributor)
      ..writeByte(9)
      ..write(obj.contributorNote)
      ..writeByte(10)
      ..write(obj.createdDate)
      ..writeByte(11)
      ..write(obj.description)
      ..writeByte(12)
      ..write(obj.firstChapterLink)
      ..writeByte(13)
      ..write(obj.price)
      ..writeByte(14)
      ..write(obj.primaryIsbn10)
      ..writeByte(15)
      ..write(obj.primaryIsbn13)
      ..writeByte(16)
      ..write(obj.bookUri)
      ..writeByte(17)
      ..write(obj.publisher)
      ..writeByte(18)
      ..write(obj.rank)
      ..writeByte(19)
      ..write(obj.rankLastWeek)
      ..writeByte(20)
      ..write(obj.sundayReviewLink)
      ..writeByte(21)
      ..write(obj.title)
      ..writeByte(22)
      ..write(obj.updatedDate)
      ..writeByte(23)
      ..write(obj.weeksOnList)
      ..writeByte(24)
      ..write(obj.buyLinks);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BooksVOAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Books _$BooksFromJson(Map<String, dynamic> json) => Books(
      json['age_group'] as String?,
      json['amazon_product_url'] as String?,
      json['article_chapter_link'] as String?,
      json['author'] as String?,
      json['book_image'] as String?,
      (json['book_image_width'] as num?)?.toInt(),
      (json['book_image_height'] as num?)?.toInt(),
      json['book_review_link'] as String?,
      json['contributor'] as String?,
      json['contributor_note'] as String?,
      json['created_date'] as String?,
      json['description'] as String?,
      json['first_chapter_link'] as String?,
      json['price'] as String?,
      json['primary_isbn10'] as String?,
      json['primary_isbn13'] as String?,
      json['book_uri'] as String?,
      json['publisher'] as String?,
      (json['rank'] as num?)?.toInt(),
      (json['rank_last_week'] as num?)?.toInt(),
      json['sunday_review_link'] as String?,
      json['title'] as String?,
      json['updated_date'] as String?,
      (json['weeks_on_list'] as num?)?.toInt(),
      (json['buy_links'] as List<dynamic>?)
          ?.map((e) => BuyLinks.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$BooksToJson(Books instance) => <String, dynamic>{
      'age_group': instance.ageGroup,
      'amazon_product_url': instance.amazonProductUrl,
      'article_chapter_link': instance.articleChapterLink,
      'author': instance.author,
      'book_image': instance.bookImage,
      'book_image_width': instance.bookImageWidth,
      'book_image_height': instance.bookImageHeight,
      'book_review_link': instance.bookReviewLink,
      'contributor': instance.contributor,
      'contributor_note': instance.contributorNote,
      'created_date': instance.createdDate,
      'description': instance.description,
      'first_chapter_link': instance.firstChapterLink,
      'price': instance.price,
      'primary_isbn10': instance.primaryIsbn10,
      'primary_isbn13': instance.primaryIsbn13,
      'book_uri': instance.bookUri,
      'publisher': instance.publisher,
      'rank': instance.rank,
      'rank_last_week': instance.rankLastWeek,
      'sunday_review_link': instance.sundayReviewLink,
      'title': instance.title,
      'updated_date': instance.updatedDate,
      'weeks_on_list': instance.weeksOnList,
      'buy_links': instance.buyLinks,
    };
