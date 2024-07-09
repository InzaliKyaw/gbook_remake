// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'price_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Price _$PriceFromJson(Map<String, dynamic> json) => Price(
      (json['amount'] as num?)?.toInt(),
      json['currencyCode'] as String?,
    );

Map<String, dynamic> _$PriceToJson(Price instance) => <String, dynamic>{
      'amount': instance.amount,
      'currencyCode': instance.currencyCode,
    };
