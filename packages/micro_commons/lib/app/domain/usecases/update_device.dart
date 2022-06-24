import 'package:either_dart/either.dart';
import 'package:micro_core/core/errors/errors.dart';
import 'package:micro_core/core/usecases/usecases.dart';

import '../repositories/api_repository.dart';

class UpdateDevice implements Usecase<DeviceParams, void> {
  final ApiRepository apiRepository;
  UpdateDevice({
    required this.apiRepository,
  });
  @override
  Future<Either<Failure, void>> call(DeviceParams params) async {
    return await apiRepository.updateDevice(params);
  }
}

class DeviceParams {
  final String guidUser;
  final String? token;
  final String platform;
  DeviceParams({
    required this.guidUser,
    required this.token,
    required this.platform,
  });

  Map<String, dynamic> toMap() {
    return {
      'guid_user': guidUser,
      'token': token,
      'platform': platform,
    };
  }
}
