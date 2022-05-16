import 'package:flutter/material.dart';
import 'package:micro_core/core/theme/theme.dart';

import '../../domain/usecases/notify_api.dart';
import '../../domain/usecases/register_account.dart';
import '../verification_email/verification_email_page.dart';

class RegisterController extends ValueNotifier {
  final RegisterAccount _registerAccount;
  final NotifyApi _notifyApi;

  final PageController pageViewController = PageController();

  RegisterController(
    this._registerAccount,
    this._notifyApi,
  ) : super(null);

  final ValueNotifier<int> _page = ValueNotifier<int>(0);
  final ValueNotifier<String> _name = ValueNotifier<String>('');
  final ValueNotifier<String> _email = ValueNotifier<String>('');
  final ValueNotifier<String> _error = ValueNotifier<String>('');
  final ValueNotifier<String> _password = ValueNotifier<String>('');
  final ValueNotifier<String> _confirmPassword = ValueNotifier<String>('');
  final ValueNotifier<bool> _isNextPage = ValueNotifier<bool>(false);
  final ValueNotifier<bool> _isFocus = ValueNotifier<bool>(false);
  final ValueNotifier<bool> _isLoad = ValueNotifier<bool>(false);

  int get page => _page.value;
  String get email => _email.value;
  String get name => _name.value;
  String get password => _password.value;
  String get confirmPassword => _confirmPassword.value;
  bool get isNextPage => _isNextPage.value;
  bool get isFocus => _isFocus.value;
  String get error => _error.value;
  bool get isLoad => _isLoad.value;

  Future<void> registerAccount(BuildContext context) async {
    isLoad = true;
    final registerParams = LoginParams(email: email, password: password);
    final result = await _registerAccount.call(registerParams);
    result.fold((resultError) {
      error = resultError.message;
    }, (resultSuccess) {
      notify(context, name: name);
    });
    isLoad = false;
  }

  Future<void> notify(BuildContext context, {String? name}) async {
    final result = await _notifyApi.call(name);
    result.fold(
      (resultError) {
        error = resultError.message;
      },
      (resultSuccess) async {
        AppDefault.navigateToWidget(
          context,
          withReturn: false,
          widget: VerificationEmailPage(
            email: email,
          ),
        );
      },
    );
  }

  set isNextPage(bool isNext) {
    _isNextPage.value = isNext;
    notifyListeners();
  }

  set isFocus(bool isFocus) {
    _isFocus.value = isFocus;
    notifyListeners();
  }

  set isLoad(bool isLoad) {
    _isLoad.value = isLoad;
    notifyListeners();
  }

  set page(int page) {
    _page.value = page;
    notifyListeners();
  }

  set email(String email) {
    _email.value = email;
    notifyListeners();
  }

  set error(String error) {
    _error.value = error;
    notifyListeners();
  }

  set name(String name) {
    _name.value = name;
    notifyListeners();
  }

  set password(String password) {
    _password.value = password;
    notifyListeners();
  }

  set confirmPassword(String confirmPassword) {
    _confirmPassword.value = confirmPassword;
    notifyListeners();
  }

  void setPage(int nextPage) {
    if (nextPage == 0 && name.isNotEmpty) {
      isNextPage = true;
    } else if (nextPage == 1 && email.isNotEmpty) {
      isNextPage = true;
    } else if (nextPage == 2 && password.isNotEmpty) {
      isNextPage = true;
    } else {
      isNextPage = false;
    }
    page = nextPage;
  }

  void nextPage() {
    pageViewController.nextPage(
        duration: const Duration(milliseconds: 200), curve: Curves.bounceIn);
    notifyListeners();
  }

  void previousPage() {
    pageViewController.previousPage(
        duration: const Duration(milliseconds: 200), curve: Curves.bounceInOut);
    notifyListeners();
  }
}
