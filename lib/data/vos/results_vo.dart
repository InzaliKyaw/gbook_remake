import 'package:gbook_remake/data/vos/book_vo.dart';
import 'package:gbook_remake/data/vos/ny_book_list.dart';
import 'package:json_annotation/json_annotation.dart';
part 'results_vo.g.dart';

@JsonSerializable()
class Results{

  @JsonKey(name: "bestsellers_date")
  String? bestsellersDate;

  @JsonKey(name: "published_date")
  String?  publishedDate;

  @JsonKey(name: "published_date_description")
  String?  publishedDateDescription;

  @JsonKey(name: "previous_published_date")
  String?  previousPublishedDate;

  @JsonKey(name: "next_published_date")
  String?  nextPublishedDate;

  @JsonKey(name: "lists")
  List<NyBookList>? lists;

  @JsonKey(name:"books")
  List<Books>? bookList;

  Results(
      this.bestsellersDate,
      this.publishedDate,
      this.publishedDateDescription,
      this.previousPublishedDate,
      this.nextPublishedDate,
      this.lists,
      this.bookList);

  factory Results.fromJson(Map<String, dynamic> json) => _$ResultsFromJson(json);
  Map<String, dynamic> toJson() => _$ResultsToJson(this);
}
