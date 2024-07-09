import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:gbook_remake/data/vos/book_vo.dart';
import 'package:gbook_remake/data/vos/error_vo.dart';
import 'package:gbook_remake/data/vos/ny_book_list.dart';
import 'package:gbook_remake/data/vos/results_vo.dart';
import 'package:gbook_remake/exception/custom_exception.dart';
import 'package:gbook_remake/network/response/gbook_api.dart';
import 'package:gbook_remake/network/data_agent/gbook_data_agent.dart';
import 'package:gbook_remake/network/response/get_book_response.dart';
import 'package:gbook_remake/network/response/get_ny_bestseller_response.dart';

class RetrofitDataAgentImpl extends GBookDataAgent{

  late GBookApi mApi;
  static RetrofitDataAgentImpl? _singleton;

  factory RetrofitDataAgentImpl() {
    _singleton ??= RetrofitDataAgentImpl._internal();
    return _singleton!;
  }

  RetrofitDataAgentImpl._internal() {
    final dio = Dio();
    mApi = GBookApi(dio);
  }

  @override
  Future<GetBookResponse?> getGoogleBooks(String q) {
    return mApi.getBooks(q)
          .catchError((error){
            throw _createException(error);
    });
  }

  CustomException _createException(dynamic error) {
    ErrorVO errorVO;
    if (error is DioException) {
      errorVO = _parseDioError(error);
    } else {
      errorVO = ErrorVO(
          statusCode: 0, statusMessage: "Unexpected error", success: false);
    }
    return CustomException(errorVO);
  }

  /// String htote -> Map<String, dynamic> pyg -> pyi mha ErrorVO
  ErrorVO _parseDioError(DioException error) {
    try {
      if (error.response != null && error.response?.data != null) {
        var data = error.response?.data;

        /// Json String to Map<String, dynamic>
        if (data is String) {
          data = jsonDecode(data);
        }

        /// Map<String, dynamic> to ErrorVO
        return ErrorVO.fromJson(data);
      } else {
        return ErrorVO(
            statusCode: 0, statusMessage: "No response data", success: false);
      }
    } catch (e) {
      return ErrorVO(
          statusCode: 0,
          statusMessage: "Error parsing DioError: $e",
          success: false);
    }
  }

  @override
  Future<List<NyBookList>?> getNYBooks(String apiKey) {
    return mApi.getNYBooks(apiKey)
        .asStream()
        .map((response) => response?.results?.lists)
         .first
        .catchError((error){
      throw _createException(error);
    });
  }

  @override
  Future<Results?> getNYBooksByCategory(String apiKey, String listName) {
    return mApi.getNYBooksByCategory(apiKey,listName)
        .asStream()
        .map((response) => response?.results)
        .first
        .catchError((error){
      throw _createException(error);
    });
  }

}