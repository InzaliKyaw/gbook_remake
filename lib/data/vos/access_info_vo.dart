import 'package:gbook_remake/data/vos/book_type_vo.dart';
import 'package:json_annotation/json_annotation.dart';
part 'access_info_vo.g.dart';

@JsonSerializable()
class AccessInfo{
  @JsonKey(name: "country")
  String? country;

  @JsonKey(name: "viewability")
  String? viewability;

  @JsonKey(name: "embeddable")
  bool? embeddable;

  @JsonKey(name: "publicDomain")
  bool? publicDomain;

  @JsonKey(name: "textToSpeechPermission")
  String? textToSpeechPermission;

  @JsonKey(name: "epub")
  BookType? epub;

  @JsonKey(name: "pdf")
  BookType? pdf;

  @JsonKey(name: "webReaderLink")
  BookType? webReaderLink;

  @JsonKey(name: "accessViewStatus")
  String? accessViewStatus;

  @JsonKey(name: "quoteSharingAllowed")
  bool? quoteSharingAllowed;

  AccessInfo(
      this.country,
      this.viewability,
      this.embeddable,
      this.publicDomain,
      this.textToSpeechPermission,
      this.epub,
      this.pdf,
      this.webReaderLink,
      this.accessViewStatus,
      this.quoteSharingAllowed);

// factory AccessInfo.fromJson(Map<String, dynamic> json) => _$AccessInfoFromJson(json);
  // Map<String, dynamic> toJson() => _$AccessInfoToJson(this);
}