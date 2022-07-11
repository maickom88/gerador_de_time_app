import 'package:flutter/material.dart';
import 'package:micro_commons/app/components/error_page.dart';
import 'package:micro_commons/app/components/loading_sport.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:micro_commons/app/domain/entities/goal_entity.dart';
import 'package:micro_commons/app/domain/entities/match_entity.dart';
import 'package:countdown_progress_indicator/countdown_progress_indicator.dart';
import 'package:micro_commons/app/domain/entities/team_entity.dart';
import 'package:micro_core/core/theme/theme.dart';

import '../../domain/usecases/register_goal.dart';
import '../../domain/usecases/remove_goal.dart';
import '../../domain/usecases/update_match.dart';
import '../../domain/usecases/update_team.dart';

class GameController extends ValueNotifier {
  final MatchEntity match;
  final RegisterGoal _registerGoal;
  final RemoveGoal _removeGoal;
  final UpdateTeam _updateTeam;
  final UpdateMatch _updateMatch;
  late CountDownController countdownController;
  GameController(
    this.match,
    this._registerGoal,
    this._removeGoal,
    this._updateTeam,
    this._updateMatch,
  ) : super(null) {
    countdownController = CountDownController();
    timeAdditions = match.timeAdditions;
  }

  final ValueNotifier<int> _totalTimePause = ValueNotifier<int>(0);
  final ValueNotifier<int> _completeTime = ValueNotifier<int>(0);
  final ValueNotifier<int?> _timeAdditions = ValueNotifier<int?>(null);
  final ValueNotifier<int> _scoreboardOpposing = ValueNotifier<int>(0);
  final ValueNotifier<int> _scoreboardHome = ValueNotifier<int>(0);
  final ValueNotifier<bool> _isPlay = ValueNotifier<bool>(true);
  final ValueNotifier<List<GoalEntity>> _goalsHome =
      ValueNotifier<List<GoalEntity>>([]);
  final ValueNotifier<List<GoalEntity>> _goalsOpposing =
      ValueNotifier<List<GoalEntity>>([]);
  final ValueNotifier<bool> _isPause = ValueNotifier<bool>(false);

  int time = 0;

  int get totalTimePause => _totalTimePause.value;
  int? get timeAdditions => _timeAdditions.value;
  int get completeTime => _completeTime.value;
  int get scoreboardOpposing => _scoreboardOpposing.value;
  int get scoreboardHome => _scoreboardHome.value;
  List<GoalEntity> get goalsHome => _goalsHome.value;
  List<GoalEntity> get goalsOpposing => _goalsOpposing.value;
  bool get isPlay => _isPlay.value;
  bool get isPause => _isPause.value;
  bool showAdditions = false;

  Future<void> registerGoal(
      {required String guidPlayer, required bool isHome}) async {
    final params = GoalParams(
      guidMacth: match.guid,
      guidPlayer: guidPlayer,
      timeGoals: time.toString(),
    );
    final result = await _registerGoal.call(params);

    result.fold((resultError) {}, (resultSuccess) async {
      if (isHome) {
        addGoalsHome(resultSuccess);
      } else {
        addGoalsOpposing(resultSuccess);
      }
    });
  }

  Future<void> removerGoal(BuildContext context,
      {required String guidPlayer,
      required GoalEntity goal,
      required bool isHome}) async {
    final result = await _removeGoal.call(goal.guid!);
    result.fold((resultError) {
      showCupertinoModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
            color: Colors.white,
            padding: const EdgeInsets.only(top: 30),
            height: 380,
            child: Material(
              color: Colors.white,
              child: ErrorComponent(
                height: 60,
                onLoad: () {
                  AppDefault.close(context);
                  removerGoal(context,
                      goal: goal, guidPlayer: guidPlayer, isHome: isHome);
                },
              ),
            ),
          );
        },
      );
    }, (resultSuccess) async {
      if (isHome) {
        removeGoalsHome(goal);
      } else {
        removeGoalsOpposing(goal);
      }
    });
  }

  Future<void> updateTeam(TeamEntity team, int score, int negativeScore) async {
    final params = UpdateTeamParams(
      color: team.color,
      goals: (team.goals + score),
      goalsNegative: (team.goalsNegative + negativeScore),
      guid: team.guid!,
      name: team.name,
      victories: score > negativeScore ? (team.victories + 1) : team.victories,
    );
    final result = await _updateTeam.call(params);

    result.fold((resultError) {}, (resultSuccess) async {});
  }

  Future<void> updateMatch(BuildContext context) async {
    AppDefault.showDefaultLoad(
      context,
      const LoadingSport(
        message: 'Finalizando jogo...',
      ),
    );
    final params = UpdateMatchParams(
      finalTime: time,
      guid: match.guid,
      totalGoals: scoreboardHome + scoreboardOpposing,
      totalTimePause: 0,
    );
    final result = await _updateMatch.call(params);

    result.fold((resultError) {
      AppDefault.close(context);
      showCupertinoModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
            color: Colors.white,
            padding: const EdgeInsets.only(top: 30),
            height: 380,
            child: Material(
              color: Colors.white,
              child: ErrorComponent(
                height: 60,
                onLoad: () {
                  AppDefault.close(context);
                  updateMatch(context);
                },
              ),
            ),
          );
        },
      );
    }, (resultSuccess) async {
      await Future.wait([
        updateTeam(match.homeTeam, scoreboardHome, scoreboardOpposing),
        updateTeam(match.opposingTeam, scoreboardOpposing, scoreboardHome),
      ]);
      AppDefault.close(context);
      AppDefault.close(context);
    });
  }

  set totalTimePause(int value) {
    _totalTimePause.value += value;
    notifyListeners();
  }

  set completeTime(int value) {
    _completeTime.value = value;
    notifyListeners();
  }

  set timeAdditions(int? value) {
    _timeAdditions.value = value;
    notifyListeners();
  }

  void addGoalsOpposing(GoalEntity value) {
    scoreboardOpposing = 1;
    _goalsOpposing.value.add(value);
    notifyListeners();
  }

  void addGoalsHome(GoalEntity value) {
    scoreboardHome = 1;
    _goalsHome.value.add(value);
    notifyListeners();
  }

  void removeGoalsHome(GoalEntity value) {
    _goalsHome.value.removeWhere((element) => element.guid == value.guid);
    _scoreboardHome.value = (scoreboardHome - 1);
    notifyListeners();
  }

  void removeGoalsOpposing(GoalEntity value) {
    _goalsOpposing.value.removeWhere((element) => element.guid == value.guid);
    _scoreboardOpposing.value = (scoreboardOpposing - 1);
    notifyListeners();
  }

  set scoreboardOpposing(int value) {
    _scoreboardOpposing.value += value;
    notifyListeners();
  }

  set scoreboardHome(int value) {
    _scoreboardHome.value += value;
    notifyListeners();
  }

  set isPause(bool value) {
    _isPause.value = value;
    notifyListeners();
  }

  set isPlay(bool value) {
    _isPlay.value = value;
    notifyListeners();
  }
}
