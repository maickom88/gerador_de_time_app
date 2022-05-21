import 'package:flutter/material.dart';
import 'package:micro_commons/app/domain/entities/player_entity.dart';
import 'package:micro_commons/app/domain/entities/user_entity.dart';
import 'package:micro_commons/app/domain/usecases/get_players_usecase.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../states/cup_state.dart';

class CupController extends ValueNotifier<CupState> {
  final GetPlayers _getPlayers;
  final SharedPreferences _sharedPreferences;

  final ValueNotifier<List<PlayerEntity>> _searchResultPlayer =
      ValueNotifier<List<PlayerEntity>>([]);
  late final ValueNotifier<UserEntity?> _userEntity =
      ValueNotifier<UserEntity?>(null);

  List<PlayerEntity> playerSelected = [];
  List<PlayerEntity> get searchResultPlayer => _searchResultPlayer.value;
  UserEntity? get userEntity => _userEntity.value;

  CupController(
    this._getPlayers,
    this._sharedPreferences,
  ) : super(InitialCupState());

  Future<void> getPlayers() async {
    value = CupLoandingState();
    if (_sharedPreferences.containsKey('user')) {
      userEntity = UserEntity.fromJson(_sharedPreferences.getString('user')!);
      final result = await _getPlayers.call(userEntity!.guid);
      result.fold((resultError) {
        value = CupErrorState(error: resultError);
      }, (resultSuccess) async {
        await Future.delayed(const Duration(seconds: 2));
        resultSuccess.sort((a, b) {
          return a.name.toLowerCase().compareTo(b.name.toLowerCase());
        });
        value = CupSuccessState(players: resultSuccess);
      });
    }
  }

  void searchPlayer(String search) {
    if (value is CupSuccessState) {
      searchResultPlayer = (value as CupSuccessState)
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
