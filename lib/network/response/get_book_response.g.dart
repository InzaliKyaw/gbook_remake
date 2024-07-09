// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_book_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetBookResponse _$GetBookResponseFromJson(Map<String, dynamic> json) =>
    GetBookResponse(
      json['kind'] as String?,
      (json['totalItems'] as num?)?.toInt(),
      (json['items'] as List<dynamic>?)
          ?.map((e) => Items.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GetBookResponseToJson(GetBookResponse instance) =>
    <String, dynamic>{
      'kind': instance.kind,
      'totalItems': instance.totalItems,
      'items': instance.items,
    };
