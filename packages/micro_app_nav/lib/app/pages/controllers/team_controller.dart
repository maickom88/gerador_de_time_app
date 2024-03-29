import 'package:flutter/material.dart';
import 'package:micro_commons/app/domain/entities/player_entity.dart';
import 'package:micro_commons/app/domain/entities/user_entity.dart';
import 'package:micro_commons/app/domain/usecases/get_players_usecase.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../domain/entities/skill_entity.dart';
import '../../domain/usecases/remove_players_usecase.dart';
import '../../domain/usecases/save_player_usecase.dart';
import '../../domain/usecases/save_skill_usecase.dart';
import '../states/team_state.dart';

class TeamController extends ValueNotifier<TeamState> {
  final GetPlayers _getPlayers;
  final SavePlayer _savePlayer;
  final SaveSkill _saveSkill;
  final RemovePlayers _removePlayers;
  final SharedPreferences _sharedPreferences;

  final ValueNotifier<List<PlayerEntity>> _searchResultPlayer =
      ValueNotifier<List<PlayerEntity>>([]);
  late final ValueNotifier<UserEntity?> _userEntity =
      ValueNotifier<UserEntity?>(null);

  List<PlayerEntity> get searchResultPlayer => _searchResultPlayer.value;
  UserEntity? get userEntity => _userEntity.value;
  SkillEntity? skill;
  List<PlayerEntity> playerSelected = [];

  TeamController(
    this._getPlayers,
    this._savePlayer,
    this._removePlayers,
    this._saveSkill,
    this._sharedPreferences,
  ) : super(InitialTeamState());

  Future<void> getPlayers() async {
    value = TeamLoandingState();
    if (_sharedPreferences.containsKey('user')) {
      userEntity = UserEntity.fromJson(_sharedPreferences.getString('user')!);
      final result = await _getPlayers.call(userEntity!.guid);
      result.fold((resultError) {
        value = TeamErrorState(error: resultError);
      }, (resultSuccess) async {
        await Future.delayed(const Duration(seconds: 2));
        resultSuccess.sort((a, b) {
          return a.name.toLowerCase().compareTo(b.name.toLowerCase());
        });
        value = TeamSuccessState(players: resultSuccess);
      });
    }
  }

  Future<bool> savePLayer(SavePlayerParams params) async {
    final result = await _savePlayer.call(params);
    final resultSavePlayer = await result.fold<Future<bool>>((resultError) {
      return Future.value(false);
    }, (resultSuccess) async {
      if (value is TeamSuccessState) {
        (value as TeamSuccessState).players.add(resultSuccess);
        (value as TeamSuccessState).players.sort(
            (a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()));
        notifyListeners();
      }

      return true;
    });
    return resultSavePlayer;
  }

  Future<bool> saveSkill(SkillEntity params) async {
    final result = await _saveSkill.call(params);
    final resultSaveSkill = await result.fold<Future<bool>>((resultError) {
      return Future.value(false);
    }, (resultSuccess) async {
      skill = resultSuccess;
      return true;
    });
    return resultSaveSkill;
  }

  Future<bool> removePLayers({bool removerAll = false}) async {
    List<String> params;
    if (removerAll) {
      params = (value as TeamSuccessState).players.map((e) => e.guid!).toList();
    } else {
      params = playerSelected.map((e) => e.guid!).toList();
    }
    final result = await _removePlayers.call(params);
    final resultRemovePlayers = await result.fold<Future<bool>>((resultError) {
      return Future.value(false);
    }, (resultSuccess) async {
      (value as TeamSuccessState)
          .players
          .removeWhere((element) => params.contains(element.guid));
      return true;
    });

    return resultRemovePlayers;
  }

  void searchPlayer(String search) {
    if (value is TeamSuccessState) {
      searchResultPlayer = (value as TeamSuccessState)
          .players
          .where((element) =>
              element.name.toLowerCase().contains(search.toLowerCase()))
          .toList();
    }
  }

  set userEntity(UserEntity? user) {
    _userEntity.value = user;
    notifyListeners();
  }

  set searchResultPlayer(List<PlayerEntity> player) {
    _searchResultPlayer.value = player;
    notifyListeners();
  }
}
