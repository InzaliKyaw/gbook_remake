// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ny_book_list.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NyBookList _$NyBookListFromJson(Map<String, dynamic> json) => NyBookList(
      listId: (json['list_id'] as num?)?.toInt(),
      listName: json['list_name'] as String?,
      listNameEncoded: json['list_name_encoded'] as String?,
      displayName: json['display_name'] as String?,
      updated: json['updated'] as String?,
      listImage: json['list_image'] as String?,
      listImageWidth: json['list_image_width'] as String?,
      listImageHeight: json['list_image_height'] as String?,
      books: (json['books'] as List<dynamic>?)
          ?.map((e) => Books.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$NyBookListToJson(NyBookList instance) =>
    <String, dynamic>{
      'list_id': instance.listId,
      'list_name': instance.listName,
      'list_name_encoded': instance.listNameEncoded,
      'display_name': instance.displayName,
      'updated': instance.updated,
      'list_image': instance.listImage,
      'list_image_width': instance.listImageWidth,
      'list_image_height': instance.listImageHeight,
      'books': instance.books,
    };
