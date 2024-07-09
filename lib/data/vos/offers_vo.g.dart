// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'offers_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Offers _$OffersFromJson(Map<String, dynamic> json) => Offers(
      (json['finskyOfferType'] as num?)?.toInt(),
      json['listPrice'] == null
          ? null
          : PriceMicros.fromJson(json['listPrice'] as Map<String, dynamic>),
      json['retailPrice'] == null
          ? null
          : PriceMicros.fromJson(json['retailPrice'] as Map<String, dynamic>),
      json['giftable'] as bool?,
    );

Map<String, dynamic> _$OffersToJson(Offers instance) => <String, dynamic>{
      'finskyOfferType': instance.finskyOfferType,
      'listPrice': instance.listPrice,
      'retailPrice': instance.retailPrice,
      'giftable': instance.giftable,
    };
