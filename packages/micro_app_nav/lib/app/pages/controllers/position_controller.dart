import 'dart:io';

import 'package:flutter/material.dart';
import 'package:micro_commons/app/domain/entities/skill_entity.dart';
import 'package:micro_commons/app/domain/usecases/upload_file.dart';
import 'package:micro_core/core/usecases/usecases.dart';

import '../../domain/entities/position_entity.dart';
import '../../domain/usecases/get_positions_usecase.dart';
import '../states/position_state.dart';

class PositionController extends ValueNotifier<PositionState> {
  final GetPositions _positions;
  final UploadFile _uploadFile;
  final ValueNotifier<List<PositionEntity>> _searchResultPositions =
      ValueNotifier<List<PositionEntity>>([]);
  final ValueNotifier<double> progressUpload = ValueNotifier<double>(0);

  String? name;
  String? photo;
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
    this._uploadFile,
  ) : super(InitialPositionState());

  Future<void> getPositions() async {
    value = PositionLoandingState();
    final result = await _positions.call(NoParams());
    result.fold((resultError) {
      value = PositionErrorState(error: resultError);
    }, (resultSuccess) async {
      await Future.delayed(const Duration(seconds: 2));
      resultSuccess.sort((a, b) {
        return a.name.toLowerCase().compareTo(b.name.toLowerCase());
      });
      value = PositionSuccessState(positions: resultSuccess);
    });
  }

  Future<void> uploadFile(File params) async {
    final result = await _uploadFile.call(params);
    result.fold((resultError) {}, (resultSuccess) async {
      await Future.delayed(const Duration(seconds: 1));
      progressUpload.value = 0;
      photo = resultSuccess;
    });
  }

  int? calculeSkill(SkillEntity skill) {
    int maxSkill = 0;
    maxSkill =
        skill.completion + skill.dribble + skill.strength + skill.velocity;
    return maxSkill ~/ 4;
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
