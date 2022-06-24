import 'dart:io';

import 'package:flutter/material.dart';
import 'package:micro_commons/app/components/error_page.dart';
import 'package:micro_commons/app/components/loading_sport.dart';
import 'package:micro_commons/app/domain/usecases/upload_file.dart';
import 'package:micro_commons/customs/file_picker_custum.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:micro_core/core/theme/theme.dart';
import 'package:micro_core/core/usecases/usecases.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../domain/entities/user_entity.dart';
import '../../domain/usecases/logout_usecase.dart';
import '../../domain/usecases/update_user.dart';
import '../states/logout_state.dart';

class LogoutController extends ValueNotifier<LogoutState> {
  final Logout _logoutUsecase;
  final UpdateUser _updateUser;
  final UploadFile _uploadFile;
  final SharedPreferences _sharedPreferences;

  LogoutController(
    this._logoutUsecase,
    this._updateUser,
    this._uploadFile,
    this._sharedPreferences,
  ) : super(InitialLogoutState());

  late final ValueNotifier<UserEntity?> _userEntity =
      ValueNotifier<UserEntity?>(null);

  final ValueNotifier<double> progressUpload = ValueNotifier<double>(0);

  UserEntity? get userEntity => _userEntity.value;

  Future<void> initialize() async {
    value = LogoutLoandingState();
    if (_sharedPreferences.containsKey('user')) {
      userEntity = UserEntity.fromJson(_sharedPreferences.getString('user')!);
    }
    value = LogoutSuccessState();
  }

  Future<void> uploadFile(BuildContext context, File params) async {
    final result = await _uploadFile.call(params);
    result.fold((resultError) {}, (resultSuccess) async {
      await Future.delayed(const Duration(seconds: 1));
      progressUpload.value = 0;
      userEntity = userEntity?.copyWith(photo: resultSuccess);
      updateUser(context);
    });
  }

  Future<void> logout(context) async {
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

  Future<void> updateUser(context) async {
    AppDefault.showDefaultLoad(
        context,
        const LoadingSport(
          message: 'Atualizando dados...',
        ));
    final result = await _updateUser.call(userEntity!);
    result.fold((resultError) {
      AppDefault.close(context);
      showCupertinoModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
            padding: const EdgeInsets.only(top: 30),
            height: 380,
            child: Material(
              child: ErrorComponent(
                height: 60,
                onLoad: () {
                  AppDefault.close(context);
                  updateUser(context);
                },
              ),
            ),
          );
        },
      );
    }, (resultSuccess) async {
      await _sharedPreferences.setString('user', userEntity!.toJson());
      await Future.delayed(const Duration(seconds: 2));
      AppDefault.close(context);
      await CustumFilePicker.instance.closeStream();
    });
  }

  set userEntity(UserEntity? user) {
    _userEntity.value = user;
    notifyListeners();
  }
}
