// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'volume_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VolumeInfo _$VolumeInfoFromJson(Map<String, dynamic> json) => VolumeInfo(
      json['title'] as String?,
      (json['authors'] as List<dynamic>?)?.map((e) => e as String).toList(),
      json['publisher'] as String?,
      json['description'] as String?,
      json['readingModes'] == null
          ? null
          : ReadingModes.fromJson(json['readingModes'] as Map<String, dynamic>),
      (json['pageCount'] as num?)?.toInt(),
      json['printType'] as String?,
      (json['categories'] as List<dynamic>?)?.map((e) => e as String).toList(),
      json['maturityRating'] as String?,
      json['allowAnonLogging'] as bool?,
      json['contentVersion'] as String?,
      json['panelizationSummary'] == null
          ? null
          : PanelizationSummary.fromJson(
              json['panelizationSummary'] as Map<String, dynamic>),
      json['imageLinks'] == null
          ? null
          : ImageLinks.fromJson(json['imageLinks'] as Map<String, dynamic>),
      json['language'] as String?,
      json['previewLink'] as String?,
      json['infoLink'] as String?,
      json['canonicalVolumeLink'] as String?,
    );

Map<String, dynamic> _$VolumeInfoToJson(VolumeInfo instance) =>
    <String, dynamic>{
      'title': instance.title,
      'authors': instance.authors,
      'publisher': instance.publisher,
      'description': instance.description,
      'readingModes': instance.readingModes,
      'pageCount': instance.pageCount,
      'printType': instance.printType,
      'categories': instance.categories,
      'maturityRating': instance.maturityRating,
      'allowAnonLogging': instance.allowAnonLogging,
      'contentVersion': instance.contentVersion,
      'panelizationSummary': instance.panelizationSummary,
      'imageLinks': instance.imageLinks,
      'language': instance.language,
      'previewLink': instance.previewLink,
      'infoLink': instance.infoLink,
      'canonicalVolumeLink': instance.canonicalVolumeLink,
    };
