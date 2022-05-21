import 'package:flutter/material.dart';

import '../domain/usecases/get_performace_usecase.dart';
import '../states/performace_state.dart';

class PerformaceController extends ValueNotifier<PerformaceState> {
  final GetPerformacePlayer _getPerformacePlayer;
  PerformaceController(
    this._getPerformacePlayer,
  ) : super(PerformaceLoandingState());

  Future<void> getPerformace(String guid) async {
    value = PerformaceLoandingState();
    final result = await _getPerformacePlayer.call(guid);
    result.fold((resultError) {
      value = PerformaceErrorState(error: resultError);
    }, (resultSuccess) async {
      await Future.delayed(const Duration(seconds: 2));
      value = PerformaceSuccessState(perfomace: resultSuccess);
    });
  }
}
