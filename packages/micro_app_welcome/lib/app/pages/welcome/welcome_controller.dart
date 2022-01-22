import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class WelcomeController extends ValueNotifier {
  final PageController pageViewController = PageController();

  WelcomeController() : super(null);

  int get page => _page.value;

  set page(int page) {
    _page.value = page;
    notifyListeners();
  }

  final ValueNotifier _page = ValueNotifier<int>(0);

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
