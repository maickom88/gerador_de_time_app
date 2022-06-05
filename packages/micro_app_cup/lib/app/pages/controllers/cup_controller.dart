import 'package:flutter/material.dart';
import 'package:micro_commons/app/components/error_page.dart';
import 'package:micro_commons/app/components/loading_sport.dart';
import 'package:micro_commons/app/domain/entities/player_entity.dart';
import 'package:micro_commons/app/domain/entities/user_entity.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:micro_commons/app/domain/usecases/get_players_usecase.dart';
import 'package:micro_core/core/theme/app_default.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../domain/usecases/draw_players_usecase.dart';
import '../states/cup_state.dart';

class CupController extends ValueNotifier<CupState> {
  final GetPlayers _getPlayers;
  final DrawPlayers _drawPlayers;
  final SharedPreferences _sharedPreferences;

  final ValueNotifier<List<PlayerEntity>> _searchResultPlayer =
      ValueNotifier<List<PlayerEntity>>([]);

  final ValueNotifier<bool> _balanceTeams = ValueNotifier<bool>(false);
  final ValueNotifier<int> _numberOfTeam = ValueNotifier<int>(2);
  late final ValueNotifier<UserEntity?> _userEntity =
      ValueNotifier<UserEntity?>(null);

  List<PlayerEntity> playerSelected = [];
  List<PlayerEntity> get searchResultPlayer => _searchResultPlayer.value;
  bool get balanceTeams => _balanceTeams.value;
  int get numberOfTeam => _numberOfTeam.value;
  UserEntity? get userEntity => _userEntity.value;

  CupController(
    this._getPlayers,
    this._drawPlayers,
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

  Future<void> drawPLayers(BuildContext context) async {
    AppDefault.showDefaultLoad(
      context,
      const LoadingSport(
        message: 'Fazendo o sorteio...',
      ),
    );
    final params = DrawParams(
      balanceTeams: balanceTeams,
      numberOfTeams: numberOfTeam,
      players: playerSelected,
    );
    final result = await _drawPlayers.call(params);

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
                  drawPLayers(context);
                },
              ),
            ),
          );
        },
      );
    }, (resultSuccess) async {
      await Future.delayed(const Duration(seconds: 2));
      AppDefault.close(context);
      resultSuccess.email = userEntity?.email;
      AppDefault.navigateTo(
        context,
        routeName: '/config',
        arguments: resultSuccess,
      );
    });
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

  void selectedAllPlayers(List<PlayerEntity> players) {
    playerSelected = players;
    notifyListeners();
  }

  void removeSelectedAllPlayers(List<PlayerEntity> players) {
    playerSelected = [];
    notifyListeners();
  }

  set userEntity(UserEntity? user) {
    _userEntity.value = user;
    notifyListeners();
  }

  set searchResultPlayer(List<PlayerEntity> player) {
    _searchResultPlayer.value = player;
    notifyListeners();
  }

  set balanceTeams(bool value) {
    _balanceTeams.value = value;
    notifyListeners();
  }

  set numberOfTeam(int value) {
    _numberOfTeam.value = value;
    notifyListeners();
  }
}
