// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'access_info_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AccessInfo _$AccessInfoFromJson(Map<String, dynamic> json) => AccessInfo(
      json['country'] as String?,
      json['viewability'] as String?,
      json['embeddable'] as bool?,
      json['publicDomain'] as bool?,
      json['textToSpeechPermission'] as String?,
      json['epub'] == null
          ? null
          : BookType.fromJson(json['epub'] as Map<String, dynamic>),
      json['pdf'] == null
          ? null
          : BookType.fromJson(json['pdf'] as Map<String, dynamic>),
      json['webReaderLink'] == null
          ? null
          : BookType.fromJson(json['webReaderLink'] as Map<String, dynamic>),
      json['accessViewStatus'] as String?,
      json['quoteSharingAllowed'] as bool?,
    );

Map<String, dynamic> _$AccessInfoToJson(AccessInfo instance) =>
    <String, dynamic>{
      'country': instance.country,
      'viewability': instance.viewability,
      'embeddable': instance.embeddable,
      'publicDomain': instance.publicDomain,
      'textToSpeechPermission': instance.textToSpeechPermission,
      'epub': instance.epub,
      'pdf': instance.pdf,
      'webReaderLink': instance.webReaderLink,
      'accessViewStatus': instance.accessViewStatus,
      'quoteSharingAllowed': instance.quoteSharingAllowed,
    };
