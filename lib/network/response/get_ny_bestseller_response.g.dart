// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_ny_bestseller_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetNYBestSellerResponse _$GetNYBestSellerResponseFromJson(
        Map<String, dynamic> json) =>
    GetNYBestSellerResponse(
      status: json['status'] as String?,
      copyright: json['copyright'] as String?,
      numResults: (json['num_results'] as num?)?.toInt(),
      results: json['results'] == null
          ? null
          : Results.fromJson(json['results'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$GetNYBestSellerResponseToJson(
        GetNYBestSellerResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'copyright': instance.copyright,
      'num_results': instance.numResults,
      'results': instance.results,
    };
