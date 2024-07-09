import 'package:dio/dio.dart';
import 'package:gbook_remake/network/api_constants.dart';
import 'package:gbook_remake/network/response/get_book_response.dart';
import 'package:gbook_remake/network/response/get_ny_bestseller_response.dart';
import 'package:retrofit/http.dart';
part 'gbook_api.g.dart';

@RestApi(baseUrl:kBaseUrl)
abstract class GBookApi{
  factory GBookApi(Dio dio) = _GBookApi;

  @GET(kEndPointGetBook)
  Future<GetBookResponse?> getBooks(
      @Query(kParamQKey) String q);

  @GET(kEndPointGetNYBooks)
  Future<GetNYBestSellerResponse?> getNYBooks(
      @Query(kParamAPIKey) String apiKey);

  @GET("$kEndPointGetNYBookByCategory/{category_type}")
  Future<GetNYBestSellerResponse?> getNYBooksByCategory(
      @Query(kParamAPIKey) String apiKey,
      @Path("category_type") String categoryType,
      );
}