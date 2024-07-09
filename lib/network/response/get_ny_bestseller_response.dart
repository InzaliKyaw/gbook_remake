import 'package:json_annotation/json_annotation.dart';
import '../../data/vos/results_vo.dart';
part 'get_ny_bestseller_response.g.dart';

@JsonSerializable()
class GetNYBestSellerResponse {

  @JsonKey(name: "status")
  String? status;

  @JsonKey(name: "copyright")
  String? copyright;

  @JsonKey(name: "num_results")
  int? numResults;

  @JsonKey(name: "results")
  Results? results;

  GetNYBestSellerResponse({
    required this.status,
    required this.copyright,
    required this.numResults,
    required this.results,
  });

  factory GetNYBestSellerResponse.fromJson(Map<String, dynamic> json) => _$GetNYBestSellerResponseFromJson(json);
  Map<String, dynamic> toJson() => _$GetNYBestSellerResponseToJson(this);

}