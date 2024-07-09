import 'package:gbook_remake/persistance/hive_constant.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:json_annotation/json_annotation.dart';
part 'buy_links_vo.g.dart';

@JsonSerializable()
@HiveType(typeId: kHiveTypeIdBuyLinks, adapterName: kAdapterNameBuyLinksVO)
class BuyLinks{

  @JsonKey(name: "name")
  @HiveField(0)
  String? name;

  @JsonKey(name: "url")
  @HiveField(1)
  String? url;

  BuyLinks(this.name, this.url);

  factory BuyLinks.fromJson(Map<String, dynamic> json) => _$BuyLinksFromJson(json);
  Map<String, dynamic> toJson() => _$BuyLinksToJson(this);
}