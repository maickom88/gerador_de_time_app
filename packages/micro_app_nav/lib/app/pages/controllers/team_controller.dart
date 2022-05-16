import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../domain/entities/player_entity.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/usecases/get_players_usecase.dart';
import '../states/team_state.dart';

class TeamController extends ValueNotifier<TeamState> {
  final GetPlayers _getPlayers;
  final SharedPreferences _sharedPreferences;

  final ValueNotifier<List<PlayerEntity>> _searchResultPlayer =
      ValueNotifier<List<PlayerEntity>>([]);
  late final ValueNotifier<UserEntity?> _userEntity =
      ValueNotifier<UserEntity?>(null);

  List<PlayerEntity> get searchResultPlayer => _searchResultPlayer.value;
  UserEntity? get userEntity => _userEntity.value;

  TeamController(
    this._getPlayers,
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
        value = TeamSuccessState(players: resultSuccess);
      });
    }
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
