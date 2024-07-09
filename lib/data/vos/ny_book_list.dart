import 'package:gbook_remake/persistance/hive_constant.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:json_annotation/json_annotation.dart';
import 'book_vo.dart';
part 'ny_book_list.g.dart';

@JsonSerializable()
class NyBookList {

  @JsonKey(name: "list_id")
  int? listId;

  @JsonKey(name: "list_name")
  String? listName;

  @JsonKey(name: "list_name_encoded")
  String? listNameEncoded;

  @JsonKey(name: "display_name")
  String? displayName;

  @JsonKey(name: "updated")
  String? updated;

  @JsonKey(name: "list_image")
  String? listImage;

  @JsonKey(name: "list_image_width")
  String? listImageWidth;

  @JsonKey(name: "list_image_height")
  String? listImageHeight;

  @JsonKey(name: "books")
  List<Books>? books;

  NyBookList({
     this.listId,
     this.listName,
     this.listNameEncoded,
     this.displayName,
     this.updated,
     this.listImage,
     this.listImageWidth,
     this.listImageHeight,
     this.books,
  });

  factory NyBookList.fromJson(Map<String, dynamic> json) => _$NyBookListFromJson(json);
  Map<String, dynamic> toJson() => _$NyBookListToJson(this);
}