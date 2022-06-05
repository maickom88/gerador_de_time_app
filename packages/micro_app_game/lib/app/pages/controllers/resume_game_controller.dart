import 'package:flutter/material.dart';
import 'package:micro_commons/app/domain/entities/config_team_entity.dart';

import '../../domain/usecases/initialize_cup.dart';
import '../states/cup_state.dart';

class ResumeController extends ValueNotifier<ResumeState> {
  final InitializeCup _initializeCup;
  final ConfigTeamEntity configCup;
  ResumeController(
    this._initializeCup, {
    required this.configCup,
  }) : super(ResumeLoandingState());

  Future<void> initializeCup() async {
    value = ResumeLoandingState();
    final params = CupParams(
      guidTeams: configCup.teams.map((e) => e!.guid!).toList(),
      time: configCup.time,
      timeAdditions: configCup.timeAdditions,
      responsibleEmail: configCup.email,
    );
    final result = await _initializeCup.call(params);

    result.fold((resultError) {
      value = ResumeErrorState(error: resultError);
    }, (resultSuccess) async {
      value = ResumeSuccessState(cup: resultSuccess);
    });
  }
}
