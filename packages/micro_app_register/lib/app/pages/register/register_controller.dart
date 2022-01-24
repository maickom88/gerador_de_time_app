import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class RegisterController extends ValueNotifier {
  final PageController pageViewController = PageController();

  RegisterController() : super(null);

  final ValueNotifier<int> _page = ValueNotifier<int>(0);
  final ValueNotifier<String> _name = ValueNotifier<String>('');
  final ValueNotifier<String> _email = ValueNotifier<String>('');
  final ValueNotifier<String> _password = ValueNotifier<String>('');
  final ValueNotifier<String> _confirmPassword = ValueNotifier<String>('');
  final ValueNotifier<bool> _isNextPage = ValueNotifier<bool>(false);
  final ValueNotifier<bool> _isFocus = ValueNotifier<bool>(false);

  int get page => _page.value;
  String get email => _email.value;
  String get name => _name.value;
  String get password => _password.value;
  String get confirmPassword => _confirmPassword.value;
  bool get isNextPage => _isNextPage.value;
  bool get isFocus => _isFocus.value;

  set isNextPage(bool isNext) {
    _isNextPage.value = isNext;
    notifyListeners();
  }

  set isFocus(bool isFocus) {
    _isFocus.value = isFocus;
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
