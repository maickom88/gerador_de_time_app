import 'package:micro_core/core/errors/errors.dart';

import '../../domain/entities/sport_entity.dart';

abstract class HomeState {}

class HomeLoandingState extends HomeState {}

class InitialHomeState extends HomeState {}

class HomeSuccessState extends HomeState {
  final List<SportEntity> sports;
  HomeSuccessState({
    required this.sports,
  });
}

class HomeErrorState extends HomeState {
  final Failure error;
  HomeErrorState({
    required this.error,
  });
}
