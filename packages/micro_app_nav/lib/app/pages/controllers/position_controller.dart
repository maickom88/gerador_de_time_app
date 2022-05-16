import 'package:flutter/material.dart';
import 'package:micro_core/core/usecases/usecases.dart';

import '../../domain/entities/position_entity.dart';
import '../../domain/entities/skill_entity.dart';
import '../../domain/usecases/get_positions_usecase.dart';
import '../states/position_state.dart';

class PositionController extends ValueNotifier<PositionState> {
  final GetPositions _positions;

  final ValueNotifier<List<PositionEntity>> _searchResultPositions =
      ValueNotifier<List<PositionEntity>>([]);

  String? name;
  int? strength;
  int? velocity;
  int? completion;
  int? dribble;
  PositionEntity? positionEntity;
  SkillEntity? skillEntity;

  List<PositionEntity> get searchResultPositions =>
      _searchResultPositions.value;

  PositionController(
    this._positions,
  ) : super(InitialPositionState());

  Future<void> getPositions() async {
    value = PositionLoandingState();
    final result = await _positions.call(NoParams());
    result.fold((resultError) {
      value = PositionErrorState(error: resultError);
    }, (resultSuccess) async {
      await Future.delayed(const Duration(seconds: 2));
      value = PositionSuccessState(positions: resultSuccess);
    });
  }

  void searchPosition(String search) {
    if (value is PositionSuccessState) {
      searchResultPositions = (value as PositionSuccessState)
          .positions
          .where((element) =>
              element.name.toLowerCase().contains(search.toLowerCase()))
          .toList();
    }
  }

  set searchResultPositions(List<PositionEntity> positions) {
    _searchResultPositions.value = positions;
    notifyListeners();
  }
}
