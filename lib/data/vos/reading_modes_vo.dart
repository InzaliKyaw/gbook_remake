import 'package:json_annotation/json_annotation.dart';
part 'reading_modes_vo.g.dart';

@JsonSerializable()
class ReadingModes{
  @JsonKey(name: "text")
  bool? text;

  @JsonKey(name: "image")
  bool? image;

  ReadingModes(this.text, this.image);

  factory ReadingModes.fromJson(Map<String, dynamic> json) => _$ReadingModesFromJson(json);
  Map<String, dynamic> toJson() => _$ReadingModesToJson(this);
}