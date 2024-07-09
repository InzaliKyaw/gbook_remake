import 'package:gbook_remake/data/vos/price_vo.dart';
import 'package:json_annotation/json_annotation.dart';
part 'sale_info_vo.g.dart';

@JsonSerializable()
class SaleInfo{

  @JsonKey(name: "country")
  String? country;

  @JsonKey(name: "saleability")
  String? saleAbility;

  @JsonKey(name: "isEbook")
  bool? isEbook;

  @JsonKey(name: "listPrice")
  Price? listPrice;

  @JsonKey(name: "retailPrice")
  Price? retailPrice;

  @JsonKey(name: "buyLink")
  String? buyLink;

  SaleInfo(this.country, this.saleAbility, this.isEbook, this.listPrice,
      this.retailPrice, this.buyLink);


  factory SaleInfo.fromJson(Map<String, dynamic> json) => _$SaleInfoFromJson(json);
  Map<String, dynamic> toJson() => _$SaleInfoToJson(this);
}