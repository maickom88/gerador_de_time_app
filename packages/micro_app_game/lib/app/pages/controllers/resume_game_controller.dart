import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:micro_commons/app/components/error_page.dart';
import 'package:micro_commons/app/components/loading_sport.dart';
import 'package:micro_commons/app/domain/entities/config_team_entity.dart';
import 'package:micro_commons/app/domain/entities/team_entity.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:micro_core/core/theme/theme.dart';

import '../../domain/usecases/finish_cup.dart';
import '../../domain/usecases/get_cup.dart';
import '../../domain/usecases/initialize_cup.dart';
import '../../domain/usecases/initialize_match.dart';
import '../../domain/usecases/register_goal.dart';
import '../../domain/usecases/remove_goal.dart';
import '../../domain/usecases/update_match.dart';
import '../../domain/usecases/update_team.dart';
import '../game/game_page.dart';
import '../states/resume_state.dart';
import 'game_controller.dart';

class ResumeController extends ValueNotifier<ResumeState> {
  final InitializeCup _initializeCup;
  final FinishCup _finishCup;
  final RegisterGoal _registerGoal;
  final RemoveGoal _removeGoal;
  final GetCup _getCup;
  final UpdateTeam _updateTeam;
  final UpdateMatch _updateMatch;
  final InitializeMatch _initializeMatch;
  final ConfigTeamEntity configCup;

  late TeamEntity teamRight;
  late CarouselController carouselControllerRight;
  late CarouselController carouselControllerLeft;
  late TeamEntity teamLeft;
  ResumeController(
    this._initializeMatch,
    this._removeGoal,
    this._getCup,
    this._finishCup,
    this._updateTeam,
    this._updateMatch,
    this._registerGoal,
    this._initializeCup, {
    required this.configCup,
  }) : super(ResumeLoandingState()) {
    carouselControllerRight = CarouselController();
    carouselControllerLeft = CarouselController();
    teamLeft = configCup.teams[0]!;
    teamRight = configCup.teams[0]!;
  }

  final ValueNotifier<List<TeamEntity?>> _teamRight =
      ValueNotifier<List<TeamEntity?>>([]);
  final ValueNotifier<List<TeamEntity?>> _teamLeft =
      ValueNotifier<List<TeamEntity?>>([]);

  List<TeamEntity?> get teamsRight => _teamRight.value;
  List<TeamEntity?> get teamsLeft => _teamLeft.value;

  Future<void> initializeCup() async {
    value = ResumeLoandingState();
    buildTeamsPlay();
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
      resultSuccess.teams.sort((b, a) => a.victories.compareTo(b.victories));
      value = ResumeSuccessState(cup: resultSuccess);
    });
  }

  Future<void> getCup() async {
    final guidCup = (value as ResumeSuccessState).cup.guid!;
    value = ResumeLoandingState();
    final result = await _getCup.call(guidCup);
    result.fold((resultError) {
      value = ResumeErrorState(error: resultError);
    }, (resultSuccess) async {
      resultSuccess.teams.sort((b, a) => a.victories.compareTo(b.victories));
      value = ResumeSuccessState(cup: resultSuccess);
    });
  }

  void initializeMatch(BuildContext context) async {
    AppDefault.showDefaultLoad(
      context,
      const LoadingSport(
        message: 'Iniciando o jogo...',
      ),
    );
    final params = MatchParams(
      guidCup: (value as ResumeSuccessState).cup.guid!,
      guidHomeTeam: teamLeft.guid!,
      guidOpposingTeam: teamRight.guid!,
      time: (value as ResumeSuccessState).cup.time,
      timeAdditions: (value as ResumeSuccessState).cup.timeAdditions,
    );
    final result = await _initializeMatch.call(params);

    result.fold((resultError) {
      AppDefault.close(context);
      showCupertinoModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
            padding: const EdgeInsets.only(top: 30),
            height: 380,
            child: Material(
              child: ErrorComponent(
                height: 60,
                onLoad: () {
                  AppDefault.close(context);
                  initializeMatch(context);
                },
              ),
            ),
          );
        },
      );
    }, (resultSuccess) async {
      await Future.delayed(const Duration(seconds: 2));
      AppDefault.close(context);
      AppDefault.close(context);
      await AppDefault.navigateToWidget(context,
          widget: GamePage(
            controller: GameController(
              resultSuccess,
              _registerGoal,
              _removeGoal,
              _updateTeam,
              _updateMatch,
            ),
          ));
      getCup();
    });
  }

  void finishCup(BuildContext context) async {
    AppDefault.showDefaultLoad(
      context,
      const LoadingSport(
        message: 'Finalizando jogo...',
      ),
    );

    final result =
        await _finishCup.call((value as ResumeSuccessState).cup.guid!);

    result.fold((resultError) {
      AppDefault.close(context);
      showCupertinoModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
            padding: const EdgeInsets.only(top: 30),
            height: 380,
            child: Material(
              child: ErrorComponent(
                height: 60,
                onLoad: () {
                  AppDefault.close(context);
                  finishCup(context);
                },
              ),
            ),
          );
        },
      );
    }, (resultSuccess) async {
      await Future.delayed(const Duration(seconds: 2));
      AppDefault.close(context);
      AppDefault.navigateToRemoveAll(context, routeName: '/nav');
    });
  }

  void buildTeamsPlay() {
    teamsRight = configCup.teams;
    teamsLeft = configCup.teams;
    onEventRight(teamsRight[0]!);
    onEventRight(teamsRight[0]!);
  }

  void onEventRight(TeamEntity team) {
    teamRight = team;
    // teamsLeft = configCup.teams.where((e) => e!.guid != team.guid).toList();
  }

  void onEventLeft(TeamEntity team) {
    teamLeft = team;
    // teamsRight = configCup.teams.where((e) => e!.guid != team.guid).toList();
  }

  set teamsRight(List<TeamEntity?> teams) {
    _teamRight.value = teams;
    notifyListeners();
  }

  set teamsLeft(List<TeamEntity?> teams) {
    _teamLeft.value = teams;
    notifyListeners();
  }
}
