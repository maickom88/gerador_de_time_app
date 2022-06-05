import 'dart:async';

import 'package:flutter/material.dart';
import 'package:micro_commons/app/components/loading_sport.dart';
import 'package:micro_commons/app/domain/entities/config_team_entity.dart';
import 'package:micro_commons/app/domain/entities/draw_entity.dart';
import 'package:micro_commons/app/domain/entities/team_entity.dart';
import 'package:micro_core/core/theme/theme.dart';

import '../../domain/usecases/register_team.dart';
import '../states/cup_config_state.dart';

class CupConfigController extends ValueNotifier<CupConfigState> {
  final RegisterTeam _registerTeam;
  final DrawEntity? draw;
  CupConfigController(
    this._registerTeam, {
    this.draw,
  }) : super(CupConfigLoandingState());

  final ValueNotifier<int> time = ValueNotifier<int>(0);
  final ValueNotifier<int> timeAdditions = ValueNotifier<int>(0);
  final ValueNotifier<bool> isAdditions = ValueNotifier<bool>(false);

  Future<void> registerTeam(BuildContext context) async {
    AppDefault.showDefaultLoad(
      context,
      const LoadingSport(
        message: 'Configurando jogo...',
      ),
    );

    final result = await Future.wait<TeamEntity?>(
      draw?.teams.map((e) => onRegisterTeam(e)).toList() ?? [],
    );
    final config = ConfigTeamEntity(
      email: draw!.email!,
      teams: result,
      time: time.value,
      timeAdditions: timeAdditions.value,
      guidSport: draw?.guidSport,
    );
    await Future.delayed(const Duration(seconds: 2));
    AppDefault.close(context);
    AppDefault.navigateTo(context,
        routeName: '/resume-game', arguments: config, withReturn: false);
  }

  Future<TeamEntity?> onRegisterTeam(TeamDrawEntity teamEntity) async {
    final params = RegisterTeamParams(
      color: teamEntity.color!.value.toString(),
      guidPlayers: teamEntity.team.map((e) => e.guid!).toList(),
      name: teamEntity.title!,
    );
    final result = await _registerTeam.call(params);

    final isSucess = await result.fold(
      (resultError) {
        return;
      },
      (resultSuccess) async {
        return resultSuccess;
      },
    );
    if (isSucess is TeamEntity) {
      return isSucess;
    }
    return null;
  }

  void setValueInTeam(index, {required String title, required Color color}) {
    draw?.teams[index].title = title;
    draw?.teams[index].color = color;
    notifyListeners();
  }
}
