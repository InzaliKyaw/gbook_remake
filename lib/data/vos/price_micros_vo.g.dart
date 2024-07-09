// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'price_micros_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PriceMicros _$PriceMicrosFromJson(Map<String, dynamic> json) => PriceMicros(
      (json['amountInMicros'] as num?)?.toInt(),
      json['currencyCode'] as String?,
    );

Map<String, dynamic> _$PriceMicrosToJson(PriceMicros instance) =>
    <String, dynamic>{
      'amountInMicros': instance.amountInMicros,
      'currencyCode': instance.currencyCode,
    };
