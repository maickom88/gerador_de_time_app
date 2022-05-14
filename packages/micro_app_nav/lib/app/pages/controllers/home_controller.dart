import 'package:flutter/material.dart';
import 'package:micro_core/core/usecases/usecases.dart';

import '../../domain/entities/sport_entity.dart';
import '../../domain/usecases/get_sports_usecase.dart';
import '../states/home_state.dart';

class HomeController extends ValueNotifier<HomeState> {
  final GetSports _getSports;

  final ValueNotifier<List<SportEntity>> _searchResultSports =
      ValueNotifier<List<SportEntity>>([]);

  List<SportEntity> get searchResultSports => _searchResultSports.value;

  HomeController(
    this._getSports,
  ) : super(InitialHomeState());

  Future<void> getSports() async {
    value = HomeLoandingState();
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

  set searchResultSports(List<SportEntity> sports) {
    _searchResultSports.value = sports;
    notifyListeners();
  }
}
