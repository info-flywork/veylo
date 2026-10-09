import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:veylo/core/config/app_config.dart';

/// Backend hata cevabı: `{ "error": { "code": "...", "message": "..." } }`.
class ApiException implements Exception {
  const ApiException({this.status, required this.code, this.message});

  /// null = sunucuya hiç ulaşılamadı.
  final int? status;
  final String code;
  final String? message;

  bool get isNetwork => status == null;

  @override
  String toString() => 'ApiException($status, $code, $message)';
}

/// Tüm REST çağrıları. Her isteğe güncel Firebase ID token'ı eklenir.
class ApiClient {
  ApiClient._() {
    _dio = Dio(
      BaseOptions(
        baseUrl: AppConfig.apiUrl,
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 30),
        sendTimeout: const Duration(seconds: 60),
      ),
    );
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          if (kDebugMode && devUser != null) {
            options.headers['Authorization'] = 'Bearer dev:$devUser';
            return handler.next(options);
          }
          final forceRefresh = options.extra['forceRefresh'] == true;
          final token = await FirebaseAuth.instance.currentUser?.getIdToken(
            forceRefresh,
          );
          if (token != null) options.headers['Authorization'] = 'Bearer $token';
          handler.next(options);
        },
      ),
    );
  }

  static final ApiClient instance = ApiClient._();

  /// Sadece debug: backend'in AUTH_DEV_BYPASS girişi (`Bearer dev:<ad>`).
  /// Ayarlıysa Firebase token'ı yerine kullanılır.
  static String? devUser;

  late final Dio _dio;

  Future<dynamic> get(String path, {Map<String, dynamic>? query}) => _send(
    (extra) => _dio.get(
      path,
      queryParameters: query,
      options: Options(extra: extra),
    ),
  );

  Future<dynamic> post(String path, {Object? body}) => _send(
    (extra) => _dio.post(
      path,
      data: body,
      options: Options(extra: extra),
    ),
  );

  Future<dynamic> patch(String path, {Object? body}) => _send(
    (extra) => _dio.patch(
      path,
      data: body,
      options: Options(extra: extra),
    ),
  );

  Future<dynamic> delete(String path, {Object? body}) => _send(
    (extra) => _dio.delete(
      path,
      data: body,
      options: Options(extra: extra),
    ),
  );

  /// multipart/form-data ile tek dosya (`file` alanı).
  Future<dynamic> upload(
    String path,
    String filePath, {
    String method = 'POST',
    Map<String, dynamic>? query,
  }) {
    return _send((extra) async {
      final form = FormData.fromMap({
        'file': await MultipartFile.fromFile(filePath),
      });
      return _dio.request(
        path,
        data: form,
        queryParameters: query,
        options: Options(method: method, extra: extra),
      );
    });
  }

  /// Token süresi dolmuşsa bir kez yenileyip tekrar dener.
  Future<dynamic> _send(
    Future<Response<dynamic>> Function(Map<String, dynamic> extra) call,
  ) async {
    try {
      return (await call(const {})).data;
    } on DioException catch (e) {
      final err = _map(e);
      if (err.status == 401 && err.code == 'INVALID_TOKEN') {
        try {
          return (await call(const {'forceRefresh': true})).data;
        } on DioException catch (e2) {
          throw _map(e2);
        }
      }
      throw err;
    }
  }

  ApiException _map(DioException e) {
    final res = e.response;
    if (res == null) return const ApiException(code: 'NETWORK');
    final data = res.data;
    if (data is Map && data['error'] is Map) {
      final err = data['error'] as Map;
      return ApiException(
        status: res.statusCode,
        code: err['code']?.toString() ?? 'UNKNOWN',
        message: err['message']?.toString(),
      );
    }
    return ApiException(status: res.statusCode, code: 'HTTP_${res.statusCode}');
  }
}
