// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'results_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Results _$ResultsFromJson(Map<String, dynamic> json) => Results(
      json['bestsellers_date'] as String?,
      json['published_date'] as String?,
      json['published_date_description'] as String?,
      json['previous_published_date'] as String?,
      json['next_published_date'] as String?,
      (json['lists'] as List<dynamic>?)
          ?.map((e) => NyBookList.fromJson(e as Map<String, dynamic>))
          .toList(),
      (json['books'] as List<dynamic>?)
          ?.map((e) => Books.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ResultsToJson(Results instance) => <String, dynamic>{
      'bestsellers_date': instance.bestsellersDate,
      'published_date': instance.publishedDate,
      'published_date_description': instance.publishedDateDescription,
      'previous_published_date': instance.previousPublishedDate,
      'next_published_date': instance.nextPublishedDate,
      'lists': instance.lists,
      'books': instance.bookList,
    };
