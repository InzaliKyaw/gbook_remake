import 'package:json_annotation/json_annotation.dart';
part 'price_micros_vo.g.dart';

@JsonSerializable()
class PriceMicros{

  @JsonKey(name: "amountInMicros")
  int? amountInMicros;

  @JsonKey(name: "currencyCode")
  String? currencyCode;

  PriceMicros(this.amountInMicros, this.currencyCode);

  factory PriceMicros.fromJson(Map<String, dynamic> json) => _$PriceMicrosFromJson(json);
  Map<String, dynamic> toJson() => _$PriceMicrosToJson(this);
}