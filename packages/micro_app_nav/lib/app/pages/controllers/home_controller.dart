import 'package:flutter/material.dart';
import 'package:micro_core/core/usecases/usecases.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../domain/entities/sport_entity.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/usecases/get_sports_usecase.dart';
import '../states/home_state.dart';

class HomeController extends ValueNotifier<HomeState> {
  final GetSports _getSports;
  final SharedPreferences _sharedPreferences;

  final ValueNotifier<List<SportEntity>> _searchResultSports =
      ValueNotifier<List<SportEntity>>([]);
  late final ValueNotifier<UserEntity?> _userEntity =
      ValueNotifier<UserEntity?>(null);

  List<SportEntity> get searchResultSports => _searchResultSports.value;
  UserEntity? get userEntity => _userEntity.value;

  HomeController(
    this._getSports,
    this._sharedPreferences,
  ) : super(InitialHomeState());

  Future<void> getSports() async {
    value = HomeLoandingState();
    if (_sharedPreferences.containsKey('user')) {
      userEntity = UserEntity.fromJson(_sharedPreferences.getString('user')!);
    }
    final result = await _getSports.call(NoParams());
    result.fold((resultError) {
      value = HomeErrorState(error: resultError);
    }, (resultSuccess) async {
      await Future.delayed(const Duration(seconds: 2));
      value = HomeSuccessState(sports: resultSuccess);
    });
  }

  void searchSport(String search) {
    if (value is HomeSuccessState) {
      searchResultSports = (value as HomeSuccessState)
          .sports
          .where((element) => element.name.contains(search))
          .toList();
    }
  }

  set userEntity(UserEntity? user) {
    _userEntity.value = user;
    notifyListeners();
  }

  set searchResultSports(List<SportEntity> sports) {
    _searchResultSports.value = sports;
    notifyListeners();
  }
}
