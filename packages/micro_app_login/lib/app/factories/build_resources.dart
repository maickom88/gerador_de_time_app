import 'package:firebase_auth/firebase_auth.dart';
import 'package:micro_core/core/customs/custum_dio.dart';
import 'package:micro_core/core/customs/custum_local_storage.dart';

import '../custum_google_auth.dart';
import '../data/repositories/api.dart';
import '../data/repositories/auth.dart';
import '../domain/usecases/login_email_with_password.dart';
import '../domain/usecases/login_social_usecase.dart';
import '../domain/usecases/notify_api.dart';
import '../external/api/api_external.dart';
import '../external/firebase/auth_firebase.dart';

final googleSignIn = CustumGoogleAuth.instance;
final firebaseInstance = FirebaseAuth.instance;
final storage = CustumLocalStorage.instance.storage;
final authFirebase = AuthFirebase(
    firebaseAuth: firebaseInstance, custumGoogleAuth: googleSignIn);
final authRepository = Auth(authDatasource: authFirebase);
final loginSocialUsecase = LoginWithSocial(authRepository: authRepository);
final loginWithEmailAndPasswordUsecase =
    LoginWithEmailAndPassword(authRepository: authRepository);

final dio = CustumDio.instance;
final apiDatasource = ApiExternal(dio, storage);
final apiRepository = Api(apiDatasource: apiDatasource);
final notifyApiUsecase = NotifyApi(apiRepository: apiRepository);
