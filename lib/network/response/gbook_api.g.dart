// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gbook_api.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps,no_leading_underscores_for_local_identifiers

class _GBookApi implements GBookApi {
  _GBookApi(
    this._dio, {
    this.baseUrl,
  }) {
    baseUrl ??= 'https://api.nytimes.com/svc/books/v3';
  }

  final Dio _dio;

  String? baseUrl;

  @override
  Future<GetBookResponse?> getBooks(String q) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'q': q};
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _result = await _dio
        .fetch<Map<String, dynamic>?>(_setStreamType<GetBookResponse>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/books/v1/volumes',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              kBaseGoogleUrl,
            ))));
    final value =
        _result.data == null ? null : GetBookResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<GetNYBestSellerResponse?> getNYBooks(String apiKey) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'api-key': apiKey};
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _result = await _dio.fetch<Map<String, dynamic>?>(
        _setStreamType<GetNYBestSellerResponse>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/lists/overview.json',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = _result.data == null
        ? null
        : GetNYBestSellerResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<GetNYBestSellerResponse?> getNYBooksByCategory(
    String apiKey,
    String categoryType,
  ) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'api-key': apiKey};
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _result = await _dio.fetch<Map<String, dynamic>?>(
        _setStreamType<GetNYBestSellerResponse>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/lists/current/${categoryType}',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = _result.data == null
        ? null
        : GetNYBestSellerResponse.fromJson(_result.data!);
    return value;
  }

  RequestOptions _setStreamType<T>(RequestOptions requestOptions) {
    if (T != dynamic &&
        !(requestOptions.responseType == ResponseType.bytes ||
            requestOptions.responseType == ResponseType.stream)) {
      if (T == String) {
        requestOptions.responseType = ResponseType.plain;
      } else {
        requestOptions.responseType = ResponseType.json;
      }
    }
    return requestOptions;
  }

  String _combineBaseUrls(
    String dioBaseUrl,
    String? baseUrl,
  ) {
    if (baseUrl == null || baseUrl.trim().isEmpty) {
      return dioBaseUrl;
    }

    final url = Uri.parse(baseUrl);

    if (url.isAbsolute) {
      return url.toString();
    }

    return Uri.parse(dioBaseUrl).resolveUri(url).toString();
  }
}
