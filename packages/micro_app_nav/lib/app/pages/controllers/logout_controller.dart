import 'package:flutter/material.dart';
import 'package:micro_core/core/theme/theme.dart';
import 'package:micro_core/core/usecases/usecases.dart';

import '../../components/loading_sport.dart';
import '../../domain/usecases/logout_usecase.dart';
import '../states/logout_state.dart';

class LogoutController extends ValueNotifier<LogoutState> {
  final Logout _logoutUsecase;

  LogoutController(
    this._logoutUsecase,
  ) : super(InitialLogoutState());

  Future<void> logout(context) async {
    value = LogoutLoandingState();
    final result = await _logoutUsecase.call(NoParams());
    result.fold((resultError) {
      value = LogoutErrorState(error: resultError);
    }, (resultSuccess) async {
      AppDefault.showDefaultLoad(
          context,
          const LoadingSport(
            message: 'Saindo da conta...',
          ));
      await Future.delayed(const Duration(seconds: 2));
      AppDefault.navigateToRemoveAll(context, routeName: '/login');
    });
  }
}
