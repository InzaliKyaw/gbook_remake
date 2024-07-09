import 'package:json_annotation/json_annotation.dart';
part 'price_vo.g.dart';

@JsonSerializable()
class Price{
  @JsonKey(name: "amount")
  int? amount;

  @JsonKey(name: "currencyCode")
  String? currencyCode;

  Price(this.amount, this.currencyCode);

  factory Price.fromJson(Map<String, dynamic> json) => _$PriceFromJson(json);
  Map<String, dynamic> toJson() => _$PriceToJson(this);
}