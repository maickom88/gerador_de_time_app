import 'package:shared_preferences/shared_preferences.dart';

class CustumLocalStorage {
  late SharedPreferences _sharedPreferences;
  SharedPreferences get storage => _sharedPreferences;

  CustumLocalStorage._run();
  static final CustumLocalStorage _singleton = CustumLocalStorage._run();
  static CustumLocalStorage get instance => _singleton;
  factory CustumLocalStorage() => _singleton;

  Future<void> initialize() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }
}
