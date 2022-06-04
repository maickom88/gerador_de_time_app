import 'package:flutter/material.dart';
import 'package:micro_commons/app/domain/entities/draw_entity.dart';

import '../states/cup_config_state.dart';

class CupConfigController extends ValueNotifier<CupConfigState> {
  final DrawEntity? draw;
  CupConfigController({
    this.draw,
  }) : super(CupConfigLoandingState());

  final ValueNotifier<int> time = ValueNotifier<int>(0);
  final ValueNotifier<int> timeAdditions = ValueNotifier<int>(0);
  final ValueNotifier<bool> isAdditions = ValueNotifier<bool>(false);

  void setValueInTeam(index, {required String title, required Color color}) {
    draw?.teams[index].title = title;
    draw?.teams[index].color = color;
    notifyListeners();
  }
}
