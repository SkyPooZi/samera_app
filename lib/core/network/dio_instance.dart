import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'api_end_point.dart';

class DioInstance {
  late Dio dio;

  DioInstance() {
    dio = Dio(BaseOptions(
      baseUrl: ApiEndPoint.baseUrl,
      connectTimeout: const Duration(seconds: 60),
      receiveTimeout: const Duration(seconds: 60),
    ));
    initializeInterceptors();
  }

  Future<Response> getRequest({
    required String endpoint,
    bool? isAuthorize,
    Map<String, dynamic>? queryParameters,
  }) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    return dio.get(
      endpoint,
      queryParameters: queryParameters,
      options: Options(
        headers: {
          "Accept": "application/json",
          if (isAuthorize ?? false) "Authorization": "Bearer $token"
        },
      ),
    );
  }

  Future<Response> postRequest({
    required String endpoint,
    bool? isAuthorize,
    bool? isMultipart,
    required Object data,
    Map<String, dynamic>? queryParameters,
  }) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    return dio.post(
      endpoint,
      data: data,
      queryParameters: queryParameters,
      options: Options(
        headers: {
          "Accept": "application/json",
          if (isAuthorize ?? false) "Authorization": "Bearer $token",
          if (isMultipart ?? false) "Content-Type": "multipart/form-data",
        },
      ),
    );
  }

  Future<Response> putRequest({
    required String endpoint,
    bool? isAuthorize,
    Object? data,
    Map<String, dynamic>? queryParameters,
  }) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    return dio.put(
      endpoint,
      data: data,
      queryParameters: queryParameters,
      options: Options(
        headers: {
          "Accept": "application/json",
          if (isAuthorize ?? false) "Authorization": "Bearer $token"
        },
      ),
    );
  }

  Future<Response> deleteRequest({
    required String endpoint,
    bool? isAuthorize,
    Map<String, dynamic>? queryParameters,
  }) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    return dio.delete(
      endpoint,
      queryParameters: queryParameters,
      options: Options(
        headers: {
          "Accept": "application/json",
          if (isAuthorize ?? false) "Authorization": "Bearer $token"
        },
      ),
    );
  }

  void initializeInterceptors() {
    dio.interceptors.add(
      InterceptorsWrapper(
        onError: (error, handler) {
          return handler.next(error);
        },
        onRequest: (request, handler) {
          return handler.next(request);
        },
        onResponse: (response, handler) {
          return handler.next(response);
        },
      ),
    );
  }
}
