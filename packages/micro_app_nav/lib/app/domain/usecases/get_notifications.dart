import 'package:either_dart/either.dart';
import 'package:micro_commons/app/domain/entities/notification_entity.dart';
import 'package:micro_core/core/errors/errors.dart';
import 'package:micro_core/core/usecases/usecases.dart';

import '../repositories/api_repository.dart';

class GetNotifications implements Usecase<String, List<NotificationEntity>> {
  final ApiRepository apiRepository;
  GetNotifications({
    required this.apiRepository,
  });
  @override
  Future<Either<Failure, List<NotificationEntity>>> call(String params) async {
    return await apiRepository.getNotifications(params);
  }
}
