import 'package:json_annotation/json_annotation.dart';
part 'image_links_vo.g.dart';

@JsonSerializable()
class ImageLinks{

  @JsonKey(name: "smallThumbnail")
  String? smallThumbnail;

  @JsonKey(name: "thumbnail")
  String? thumbnail;

  ImageLinks(this.smallThumbnail, this.thumbnail);

  factory ImageLinks.fromJson(Map<String, dynamic> json) => _$ImageLinksFromJson(json);
  Map<String, dynamic> toJson() => _$ImageLinksToJson(this);
}