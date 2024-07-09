import 'package:gbook_remake/data/vos/panelization_summary_vo.dart';
import 'package:gbook_remake/data/vos/reading_modes_vo.dart';
import 'package:gbook_remake/data/vos/image_links_vo.dart';
import 'package:json_annotation/json_annotation.dart';

import 'book_vo.dart';
part 'volume_info.g.dart';

@JsonSerializable()
class VolumeInfo{
  @JsonKey(name: "title")
  String? title;

  @JsonKey(name: "authors")
  List<String>? authors;

  @JsonKey(name: "publisher")
  String? publisher;

  @JsonKey(name: "description")
  String? description;

  @JsonKey(name: "readingModes")
  ReadingModes? readingModes;

  @JsonKey(name: "pageCount")
  int? pageCount;

  @JsonKey(name: "printType")
  String? printType;

  @JsonKey(name: "categories")
  List<String>? categories;

  @JsonKey(name: "maturityRating")
  String? maturityRating;

  @JsonKey(name: "allowAnonLogging")
  bool? allowAnonLogging;

  @JsonKey(name: "contentVersion")
  String? contentVersion;

  @JsonKey(name: "panelizationSummary")
  PanelizationSummary? panelizationSummary;

  @JsonKey(name: "imageLinks")
  ImageLinks? imageLinks;

  @JsonKey(name: "language")
  String? language;

  @JsonKey(name: "previewLink")
  String? previewLink;

  @JsonKey(name: "infoLink")
  String? infoLink;

  @JsonKey(name: "canonicalVolumeLink")
  String? canonicalVolumeLink;

  VolumeInfo(
      this.title,
      this.authors,
      this.publisher,
      this.description,
      this.readingModes,
      this.pageCount,
      this.printType,
      this.categories,
      this.maturityRating,
      this.allowAnonLogging,
      this.contentVersion,
      this.panelizationSummary,
      this.imageLinks,
      this.language,
      this.previewLink,
      this.infoLink,
      this.canonicalVolumeLink);



  factory VolumeInfo.fromJson(Map<String, dynamic> json) => _$VolumeInfoFromJson(json);
  Map<String, dynamic> toJson() => _$VolumeInfoToJson(this);
}