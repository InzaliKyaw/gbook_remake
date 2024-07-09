// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'items_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Items _$ItemsFromJson(Map<String, dynamic> json) => Items(
      json['kind'] as String?,
      json['id'] as String?,
      json['etag'] as String?,
      json['selfLink'] as String?,
      json['volumeInfo'] == null
          ? null
          : VolumeInfo.fromJson(json['volumeInfo'] as Map<String, dynamic>),
      json['searchInfo'] == null
          ? null
          : SearchInfo.fromJson(json['searchInfo'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ItemsToJson(Items instance) => <String, dynamic>{
      'kind': instance.kind,
      'id': instance.id,
      'etag': instance.etag,
      'selfLink': instance.selfLink,
      'volumeInfo': instance.volumeInfo,
      'searchInfo': instance.searchInfo,
    };
