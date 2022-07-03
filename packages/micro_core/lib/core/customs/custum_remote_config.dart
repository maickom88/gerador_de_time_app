import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/services.dart';

import '../errors/errors.dart';
import '../firebase/remote_config.dart';

class CustumRemoteConfig implements IFirebaseRemoteConfig {
  late FirebaseRemoteConfig _firebaseRemoteConfig;
  String get apiBase => "http://192.168.1.3:8080";
  // String get apiBase =>
  //     getValueOrDefault<String>(key: 'DEV_API', defaultValue: '');

  CustumRemoteConfig._run();
  static final CustumRemoteConfig _singleton = CustumRemoteConfig._run();
  static CustumRemoteConfig get instance => _singleton;
  factory CustumRemoteConfig() => _singleton;

  @override
  Future<void> initialize() async {
    _firebaseRemoteConfig = FirebaseRemoteConfig.instance;
    await _firebaseRemoteConfig.setConfigSettings(
      RemoteConfigSettings(
        fetchTimeout: const Duration(seconds: 10),
        minimumFetchInterval: const Duration(hours: 1),
      ),
    );
    await _firebaseRemoteConfig.fetchAndActivate();
  }

  @override
  T getValueOrDefault<T>({required String key, required T defaultValue}) {
    switch (T) {
      case String:
        return (_firebaseRemoteConfig.getString(key) as T);
      case double:
        return (_firebaseRemoteConfig.getDouble(key) as T);
      case int:
        return (_firebaseRemoteConfig.getInt(key) as T);
      case bool:
        return (_firebaseRemoteConfig.getBool(key) as T);
      default:
        throw KeyNotExist();
    }
  }

  @override
  Future<void> forceFetch() async {
    try {
      await _firebaseRemoteConfig.setConfigSettings(
        RemoteConfigSettings(
          fetchTimeout: const Duration(seconds: 10),
          minimumFetchInterval: Duration.zero,
        ),
      );
      await _firebaseRemoteConfig.fetchAndActivate();
    } on PlatformException catch (e) {
      throw (e.toString());
    } on Exception catch (_) {
      throw ('Error fetch remote data');
    }
  }
}
