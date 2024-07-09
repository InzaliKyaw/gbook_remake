import 'package:gbook_remake/data/vos/search_info_vo.dart';
import 'package:gbook_remake/data/vos/volume_info.dart';
import 'package:json_annotation/json_annotation.dart';

import 'book_vo.dart';
part 'items_vo.g.dart';

@JsonSerializable()
class Items{
  @JsonKey(name: "kind")
  String? kind;

  @JsonKey(name: "id")
  String? id;

  @JsonKey(name: "etag")
  String? etag;

  @JsonKey(name: "selfLink")
  String? selfLink;

  @JsonKey(name: "volumeInfo")
  VolumeInfo? volumeInfo;

  @JsonKey(name: "searchInfo")
  SearchInfo? searchInfo;

  Items(this.kind, this.id, this.etag, this.selfLink, this.volumeInfo,
      this.searchInfo);

  Books convertToBookVO(){
    return Books.googleBook(volumeInfo?.authors?.first, volumeInfo?.title, volumeInfo?.imageLinks?.thumbnail);
  }

  factory Items.fromJson(Map<String, dynamic> json) => _$ItemsFromJson(json);
  Map<String, dynamic> toJson() => _$ItemsToJson(this);
}