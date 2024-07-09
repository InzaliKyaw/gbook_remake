// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sale_info_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SaleInfo _$SaleInfoFromJson(Map<String, dynamic> json) => SaleInfo(
      json['country'] as String?,
      json['saleability'] as String?,
      json['isEbook'] as bool?,
      json['listPrice'] == null
          ? null
          : Price.fromJson(json['listPrice'] as Map<String, dynamic>),
      json['retailPrice'] == null
          ? null
          : Price.fromJson(json['retailPrice'] as Map<String, dynamic>),
      json['buyLink'] as String?,
    );

Map<String, dynamic> _$SaleInfoToJson(SaleInfo instance) => <String, dynamic>{
      'country': instance.country,
      'saleability': instance.saleAbility,
      'isEbook': instance.isEbook,
      'listPrice': instance.listPrice,
      'retailPrice': instance.retailPrice,
      'buyLink': instance.buyLink,
    };
