import 'package:flutter/material.dart';
import 'package:micro_core/core/theme/theme.dart';

import '../../../core/enums/type_provider_enum.dart';
import '../../data/errors/login_cancel_error.dart';
import '../../domain/usecases/login_email_with_password.dart';
import '../../domain/usecases/login_social_usecase.dart';
import '../states/login_state.dart';

class LoginController extends ValueNotifier<LoginState> {
  final LoginWithSocial _loginWithSocial;
  final LoginWithEmailAndPassword _loginWithEmailAndPassword;

  LoginController(
    this._loginWithSocial,
    this._loginWithEmailAndPassword,
  ) : super(InitialLoginState());

  Future<void> loginSocial(context, TypeProviderSocial provider) async {
    value = LoginLoandingState();
    final result = await _loginWithSocial.call(provider);
    result.fold((resultError) {
      if (resultError is LoginCancel) {
        value = InitialLoginState();
      } else {
        value = LoginErrorState(error: resultError);
      }
    }, (resultSuccess) {
      AppDefault.navigateTo(context, routeName: '/nav', withReturn: false);
    });
  }

  void login(context, {required String email, required String password}) async {
    value = LoginLoandingState();
    final result = await _loginWithEmailAndPassword.call(
      LoginParams(email: email, password: password),
    );

    result.fold(
      (resultError) {
        value = LoginErrorState(error: resultError);
      },
      (resultSuccess) async {
        AppDefault.navigateTo(context, routeName: '/nav', withReturn: false);
      },
    );
  }
}
