import 'package:json_annotation/json_annotation.dart';
part 'book_type_vo.g.dart';

@JsonSerializable()
class BookType{
  @JsonKey(name: "isAvailable")
  bool? isAvailable;

  BookType(this.isAvailable);

  factory BookType.fromJson(Map<String, dynamic> json) => _$BookTypeFromJson(json);
  Map<String, dynamic> toJson() => _$BookTypeToJson(this);
}