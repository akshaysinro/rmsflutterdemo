import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_rms/common/error/errors.dart';

class ApiResponseHandler {
  /// Wraps an API call and returns Either a Failure or the typed Data
  static Future<Either<MainFailure, T>> handle<T>(
    Future<T> Function() apiCall,
  ) async {
    try {
      final result = await apiCall();
      return Right(result);
    } on DioException catch (e) {
      return Left(_handleDioError(e));
    } catch (e) {
      return Left(MainFailure());
    }
  }

  static MainFailure _handleDioError(DioException e) {
    switch (e.type) {
   
      case DioExceptionType.badResponse:
        // You can parse e.response?.data['message'] here if your API sends specific errors
        return MainFailure();
  
      case DioExceptionType.connectionTimeout:
        // TODO: Handle this case.
        throw UnimplementedError();
      case DioExceptionType.sendTimeout:
        // TODO: Handle this case.
        throw UnimplementedError();
      case DioExceptionType.receiveTimeout:
        // TODO: Handle this case.
        throw UnimplementedError();
      case DioExceptionType.badCertificate:
        // TODO: Handle this case.
        throw UnimplementedError();
      case DioExceptionType.cancel:
        // TODO: Handle this case.
        throw UnimplementedError();
      case DioExceptionType.connectionError:
        // TODO: Handle this case.
        throw UnimplementedError();
      case DioExceptionType.unknown:
        // TODO: Handle this case.
        throw UnimplementedError();
    }
  }
}