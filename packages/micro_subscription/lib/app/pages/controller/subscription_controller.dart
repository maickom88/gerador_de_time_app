import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:micro_commons/app/domain/entities/user_entity.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../domain/usecases/register_purchase.dart';
import '../states/subscription_state.dart';

class SubscriptionController extends ValueNotifier<SubscriptionState> {
  final RegisterPurchase _registerPurchase;
  final SharedPreferences _sharedPreferences;

  SubscriptionController(
    this._registerPurchase,
    this._sharedPreferences,
  ) : super(InitialSubscriptionState());

  late final ValueNotifier<UserEntity?> _userEntity =
      ValueNotifier<UserEntity?>(null);

  UserEntity? get userEntity => _userEntity.value;

  Future<void> saveBuy(double priceBr, double priceUsd) async {
    if (_sharedPreferences.containsKey('user')) {
      userEntity = UserEntity.fromJson(_sharedPreferences.getString('user')!);
    }
    value = SubscriptionLoandingState();
    final params = PurchaseParams(
      guidUser: userEntity!.guid,
      priceBr: priceBr,
      priceUsd: priceUsd,
      platform: Platform.isAndroid ? 'ANDROID' : 'IOS',
    );
    final result = await _registerPurchase.call(params);
    result.fold((resultError) {
      value = SubscriptionErrorState(error: resultError);
    }, (resultSuccess) async {
      userEntity?.role = RoleEnum.premium;
      await _sharedPreferences.setString('user', userEntity!.toJson());
      value = SubscriptionSuccessState();
    });
  }

  void setLoading() {
    value = SubscriptionLoandingState();
  }

  Future<void> closeLoading() async {
    await Future.delayed(const Duration(seconds: 2));
    value = InitialSubscriptionState();
  }

  set userEntity(UserEntity? user) {
    _userEntity.value = user;
    notifyListeners();
  }
}
