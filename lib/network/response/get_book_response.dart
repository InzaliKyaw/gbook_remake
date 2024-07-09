import 'package:json_annotation/json_annotation.dart';
import '../../data/vos/items_vo.dart';
part 'get_book_response.g.dart';

@JsonSerializable()
class GetBookResponse{
   @JsonKey(name:"kind")
   String? kind;

   @JsonKey(name:"totalItems")
   int? totalItems;

   @JsonKey(name:"items")
   List<Items>? items;

   GetBookResponse(this.kind, this.totalItems, this.items);

   factory GetBookResponse.fromJson(Map<String, dynamic> json) => _$GetBookResponseFromJson(json);
   Map<String, dynamic> toJson() => _$GetBookResponseToJson(this);
}