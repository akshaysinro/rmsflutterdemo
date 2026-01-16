import 'package:injectable/injectable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rms/common/network/api_client.dart.dart';
import 'package:dio/dio.dart';
import 'package:flutter_rms/common/server.dart';

class DioApiClient implements IApiClient {
  final Dio _dio = Dio();

  // Dependency Injection: Pass the Dio instance in
  DioApiClient() {
    _dio.options.baseUrl = "$localBaseUrl/";
    _dio.options.connectTimeout = const Duration(seconds: 5);

    // 1. Add standard Logging Interceptor
    _dio.interceptors.add(
      LogInterceptor(
        requestBody: true, // Log the data you are sending
        responseBody: true, // Log the data you are receiving
        logPrint: (obj) =>
            debugPrint(obj.toString()), // Use debugPrint instead of print
      ),
    );

    // Example of adding an Interceptor for Auth
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          options.headers['ngrok-skip-browser-warning'] = 'true';
          options.headers['Authorization'] = 'Bearer YOUR_TOKEN';
          options.headers['Accept'] = 'application/json';
          return handler.next(options);
        },
      ),
    );
  }

  @override
  Future<dynamic> get(
    String path, {
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final response = await _dio.get(path, queryParameters: queryParameters);
      return _handleResponse(response);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  @override
  Future<dynamic> post(String path, {dynamic data}) async {
    try {
      final response = await _dio.post(path, data: data);
      return _handleResponse(response);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Single Responsibility: Handling standard response logic
  dynamic _handleResponse(Response response) {
    if (response.statusCode! >= 200 && response.statusCode! < 300) {
      return response.data;
    } else {
      throw Exception("Server Error: ${response.statusCode}");
    }
  }

  Exception _handleError(DioException e) {
    // Map network errors to domain-specific exceptions
    return Exception(e.message ?? "Network Error");
  }

  @override
  Future delete(String path) => _dio.delete(path);

  @override
  Future put(String path, {data}) => _dio.put(path, data: data);
}
