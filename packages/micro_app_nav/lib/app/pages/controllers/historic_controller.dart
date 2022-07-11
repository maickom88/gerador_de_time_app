import 'package:flutter/material.dart';
import 'package:micro_commons/app/domain/entities/cup_entity.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../domain/entities/user_entity.dart';
import '../../domain/usecases/get_cups_usecase.dart';
import '../states/historic_state.dart';

class HistoricController extends ValueNotifier<HistoricState> {
  final GetCups _getCups;

  final SharedPreferences _sharedPreferences;

  final ValueNotifier<List<CupEntity>> _searchResultHistorics =
      ValueNotifier<List<CupEntity>>([]);
  late final ValueNotifier<UserEntity?> _userEntity =
      ValueNotifier<UserEntity?>(null);

  CupEntity? cupEntity;

  List<CupEntity> get searchResultHistorics => _searchResultHistorics.value;
  UserEntity? get userEntity => _userEntity.value;
  HistoricController(
    this._getCups,
    this._sharedPreferences,
  ) : super(InitialHistoricState());

  Future<void> getHistorics() async {
    if (_sharedPreferences.containsKey('user')) {
      userEntity = UserEntity.fromJson(_sharedPreferences.getString('user')!);
    }
    value = HistoricLoandingState();
    if (userEntity != null) {
      final result = await _getCups.call(userEntity!.email);
      result.fold((resultError) {
        value = HistoricErrorState(error: resultError);
      }, (resultSuccess) async {
        await Future.delayed(const Duration(seconds: 2));
        resultSuccess.sort((b, a) {
          return a.date.compareTo(b.date);
        });
        value = HistoricSuccessState(cups: resultSuccess);
      });
    }
  }

  void searchHistoric(String search) {
    if (value is HistoricSuccessState) {
      searchResultHistorics = (value as HistoricSuccessState)
          .cups
          .where((element) => element.winner != null
              ? element.winner!.name
                  .toLowerCase()
                  .contains(search.toLowerCase())
              : false)
          .toList();
    }
  }

  set searchResultHistorics(List<CupEntity> cups) {
    _searchResultHistorics.value = cups;
    notifyListeners();
  }

  set userEntity(UserEntity? user) {
    _userEntity.value = user;
    notifyListeners();
  }
}
