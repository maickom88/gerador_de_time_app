import 'dart:io';

import 'package:flutter/material.dart';
import 'package:micro_commons/app/domain/usecases/update_device.dart';
import 'package:micro_core/core/customs/custum_firebase_message.dart';
import 'package:micro_core/core/customs/custum_remote_config.dart';
import 'package:micro_core/core/theme/theme.dart';
import 'package:micro_core/core/usecases/usecases.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../domain/entities/sport_entity.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/usecases/get_sports_usecase.dart';
import '../../domain/usecases/logout_usecase.dart';
import '../states/home_state.dart';

class HomeController extends ValueNotifier<HomeState> {
  final GetSports _getSports;
  final UpdateDevice _updateDevice;
  final Logout _logoutUsecase;
  final SharedPreferences _sharedPreferences;

  final ValueNotifier<List<SportEntity>> _searchResultSports =
      ValueNotifier<List<SportEntity>>([]);
  late final ValueNotifier<UserEntity?> _userEntity =
      ValueNotifier<UserEntity?>(null);

  List<SportEntity> get searchResultSports => _searchResultSports.value;
  UserEntity? get userEntity => _userEntity.value;

  HomeController(
    this._getSports,
    this._updateDevice,
    this._logoutUsecase,
    this._sharedPreferences,
  ) : super(InitialHomeState());

  Future<void> getSports(BuildContext context) async {
    value = HomeLoandingState();
    if (_sharedPreferences.containsKey('user')) {
      userEntity = UserEntity.fromJson(_sharedPreferences.getString('user')!);
      if (userEntity == null ||
          userEntity?.guid == null ||
          userEntity?.guid.isEmpty == true) {
        await _sharedPreferences.remove('user');
        await CustumRemoteConfig.instance.forceFetch();
        logout(context);
      }
    } else {
      await _sharedPreferences.remove('user');
      await CustumRemoteConfig.instance.forceFetch();
      logout(context);
    }
    final result = await _getSports.call(NoParams());
    result.fold((resultError) {
      value = HomeErrorState(error: resultError);
    }, (resultSuccess) async {
      updateDevice();
      await Future.delayed(const Duration(seconds: 2));
      value = HomeSuccessState(sports: resultSuccess);
    });
  }

  Future<void> logout(BuildContext context) async {
    final result = await _logoutUsecase.call(NoParams());
    result.fold((resultError) {
      value = HomeErrorState(error: resultError);
    }, (resultSuccess) async {
      AppDefault.navigateToRemoveAll(context, routeName: '/login');
    });
  }

  Future<void> updateDevice() async {
    final token = await CustumFirebaseMessage.instance.getTokenMessage();
    final params = DeviceParams(
      guidUser: userEntity!.guid,
      token: token,
      platform: Platform.isAndroid ? 'ANDROID' : 'IOS',
    );
    final result = await _updateDevice.call(params);
    result.fold((resultError) {}, (resultSuccess) async {});
  }

  void searchSport(String search) {
    if (value is HomeSuccessState) {
      searchResultSports = (value as HomeSuccessState)
          .sports
          .where((element) =>
              element.name.toLowerCase().contains(search.toLowerCase()))
          .toList();
    }
  }

  void getUser() {
    if (_sharedPreferences.containsKey('user')) {
      userEntity = UserEntity.fromJson(_sharedPreferences.getString('user')!);
    }
  }

  set userEntity(UserEntity? user) {
    _userEntity.value = user;
    notifyListeners();
  }

  set searchResultSports(List<SportEntity> sports) {
    _searchResultSports.value = sports;
    notifyListeners();
  }
}
