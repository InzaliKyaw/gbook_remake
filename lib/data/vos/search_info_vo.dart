import 'package:json_annotation/json_annotation.dart';
part 'search_info_vo.g.dart';

@JsonSerializable()
class SearchInfo{

  @JsonKey(name: "textSnippet")
  String? textSnippet;

  SearchInfo(this.textSnippet);

  factory SearchInfo.fromJson(Map<String, dynamic> json) => _$SearchInfoFromJson(json);
  Map<String, dynamic> toJson() => _$SearchInfoToJson(this);
}