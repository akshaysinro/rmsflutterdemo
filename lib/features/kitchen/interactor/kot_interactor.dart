import 'package:flutter_rms/features/kitchen/domain/repositry/i_kitchen_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class KotInteractor {
  final IKotRepository kotRepository;

  KotInteractor({required this.kotRepository});

  Future executeGetKots() async {
    return await kotRepository.fetchKots();
  }
}
