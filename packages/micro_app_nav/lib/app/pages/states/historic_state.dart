import 'package:micro_commons/app/domain/entities/cup_entity.dart';
import 'package:micro_core/core/errors/errors.dart';

abstract class HistoricState {}

class HistoricLoandingState extends HistoricState {}

class InitialHistoricState extends HistoricState {}

class HistoricSuccessState extends HistoricState {
  final List<CupEntity> cups;
  HistoricSuccessState({
    required this.cups,
  });
}

class HistoricErrorState extends HistoricState {
  final Failure error;
  HistoricErrorState({
    required this.error,
  });
}
