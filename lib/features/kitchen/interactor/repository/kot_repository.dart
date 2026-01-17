import 'package:dartz/dartz.dart';
import 'package:flutter_rms/common/error/errors.dart';
import 'package:flutter_rms/common/network/api_client.dart';
import 'package:flutter_rms/common/network/api_response_handler.dart';
import 'package:flutter_rms/common/network/urls.dart';
import 'package:flutter_rms/features/kitchen/domain/repositry/i_kitchen_repository.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: IKotRepository)
class KotRepository implements IKotRepository {
  final IApiClient apiClient;

  KotRepository({required this.apiClient});

  @override
  Future<Either<MainFailure, dynamic>> fetchKots() async {
    return await ApiResponseHandler.handle(() => apiClient.get(Urls.getKot));
  }
}
