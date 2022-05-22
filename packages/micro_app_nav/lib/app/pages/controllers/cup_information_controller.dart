import 'package:flutter/material.dart';
import '../../domain/usecases/get_cup_information_usecase.dart';
import '../states/cup_information_state.dart';

class CupInformationController extends ValueNotifier<CupInformationState> {
  final GetCupInformation _getCupInformation;

  CupInformationController(
    this._getCupInformation,
  ) : super(InitialCupInformationState());

  Future<void> getCupInformations(String guidCup) async {
    value = CupInformationLoandingState();
    final result = await _getCupInformation.call(guidCup);
    result.fold((resultError) {
      value = CupInformationErrorState(error: resultError);
    }, (resultSuccess) async {
      await Future.delayed(const Duration(seconds: 2));
      value = CupInformationSuccessState(cupInformation: resultSuccess);
    });
  }
}
