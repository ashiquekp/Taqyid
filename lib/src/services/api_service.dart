import 'package:dio/dio.dart';

/// Custom exception for API errors
class ApiException implements Exception {
  const ApiException({required this.message, this.statusCode});
  final String message;
  final int? statusCode;

  @override
  String toString() => 'ApiException($statusCode): $message';
}

/// Logging interceptor for Dio — sanitized for production-style logging
class _LoggingInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    // ignore: avoid_print
    print('[API] --> ${options.method} ${options.uri}');
    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    // ignore: avoid_print
    print('[API] <-- ${response.statusCode} ${response.requestOptions.uri}');
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    // ignore: avoid_print
    print('[API] ERR ${err.response?.statusCode} ${err.requestOptions.uri}: ${err.message}');
    handler.next(err);
  }
}

/// Central Dio HTTP client for HadeethEnc API
class ApiService {
  ApiService._() {
    _dio = Dio(
      BaseOptions(
        baseUrl: 'https://hadeethenc.com/api/v1/',
        connectTimeout: const Duration(seconds: 15),
        receiveTimeout: const Duration(seconds: 30),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
      ),
    )..interceptors.add(_LoggingInterceptor());
  }

  static final ApiService instance = ApiService._();
  late final Dio _dio;

  /// GET /languages/
  /// Returns a list of all available languages.
  Future<List<Map<String, dynamic>>> getLanguages() async {
    return _get('languages/');
  }

  /// GET /categories/roots/?language=:lang
  Future<List<Map<String, dynamic>>> getCategoryRoots(String lang) async {
    return _get('categories/roots/', queryParameters: {'language': lang});
  }

  /// GET /categories/list/?language=:lang&parent_id=:id
  Future<List<Map<String, dynamic>>> getCategoryList(String lang, String parentId) async {
    return _get('categories/list/', queryParameters: {
      'language': lang,
      'parent_id': parentId,
    });
  }

  /// GET /hadiths/list/?language=:lang&category_id=:id&page=:page&per_page=:pp
  Future<Map<String, dynamic>> getHadithsList({
    required String lang,
    required String categoryId,
    int page = 1,
    int perPage = 20,
  }) async {
    final list = await _getRaw('hadiths/list/', queryParameters: {
      'language': lang,
      'category_id': categoryId,
      'page': page,
      'per_page': perPage,
    });
    return list as Map<String, dynamic>;
  }

  /// GET /hadiths/one/?language=:lang&id=:id
  Future<Map<String, dynamic>> getHadeethOne(String lang, String id) async {
    final raw = await _getRaw('hadiths/one/', queryParameters: {
      'language': lang,
      'id': id,
    });
    return raw as Map<String, dynamic>;
  }

  /// GET /hadiths/search/?language=:lang&term=:term&page=:page&per_page=:pp
  Future<Map<String, dynamic>> searchHadiths({
    required String lang,
    required String term,
    int page = 1,
    int perPage = 20,
  }) async {
    final raw = await _getRaw('hadiths/search/', queryParameters: {
      'language': lang,
      'term': term,
      'page': page,
      'per_page': perPage,
    });
    return raw as Map<String, dynamic>;
  }

  // ============ Internal helpers ============

  Future<List<Map<String, dynamic>>> _get(
    String path, {
    Map<String, dynamic>? queryParameters,
  }) async {
    final raw = await _getRaw(path, queryParameters: queryParameters);
    if (raw is List) {
      return raw.whereType<Map<String, dynamic>>().toList();
    }
    throw ApiException(message: 'Unexpected response format for $path');
  }

  Future<dynamic> _getRaw(
    String path, {
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final response = await _dio.get<dynamic>(
        path,
        queryParameters: queryParameters,
      );
      if (response.data == null) {
        throw const ApiException(message: 'Empty response from server');
      }
      return response.data;
    } on DioException catch (e) {
      throw ApiException(
        message: e.message ?? 'Network error',
        statusCode: e.response?.statusCode,
      );
    }
  }
}
