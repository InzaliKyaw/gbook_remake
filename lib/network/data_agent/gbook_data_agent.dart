import 'package:gbook_remake/data/vos/ny_book_list.dart';
import 'package:gbook_remake/data/vos/results_vo.dart';
import 'package:gbook_remake/network/response/get_book_response.dart';
import 'package:gbook_remake/network/response/get_ny_bestseller_response.dart';

abstract class GBookDataAgent{
  Future<GetBookResponse?> getGoogleBooks(String q);
  Future<List<NyBookList>?> getNYBooks(String apiKey);
  Future<Results?> getNYBooksByCategory(String apiKey, String category);
}