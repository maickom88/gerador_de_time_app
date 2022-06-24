import 'dart:io';

import 'package:either_dart/either.dart';
import 'package:micro_core/core/errors/errors.dart';
import 'package:micro_core/core/usecases/usecases.dart';

import '../repositories/api_repository.dart';

class UploadFile implements Usecase<File, String> {
  final ApiRepository apiRepository;
  UploadFile({
    required this.apiRepository,
  });
  @override
  Future<Either<Failure, String>> call(File params) async {
    return await apiRepository.uploadFile(params);
  }
}
