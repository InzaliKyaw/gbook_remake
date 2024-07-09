import 'package:gbook_remake/data/vos/price_micros_vo.dart';
import 'package:json_annotation/json_annotation.dart';
part 'offers_vo.g.dart';

@JsonSerializable()
class Offers{
  @JsonKey(name: "finskyOfferType")
  int? finskyOfferType;

  @JsonKey(name: "listPrice")
  PriceMicros? listPrice;

  @JsonKey(name: "retailPrice")
  PriceMicros? retailPrice;

  @JsonKey(name: "giftable")
  bool? giftable;

  Offers(this.finskyOfferType, this.listPrice, this.retailPrice, this.giftable);

  factory Offers.fromJson(Map<String, dynamic> json) => _$OffersFromJson(json);
  Map<String, dynamic> toJson() => _$OffersToJson(this);
}