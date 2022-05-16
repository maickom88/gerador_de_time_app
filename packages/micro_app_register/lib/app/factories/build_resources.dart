import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:micro_core/core/customs/custum_dio.dart';
import 'package:micro_core/core/customs/custum_local_storage.dart';

import '../data/repositories/api.dart';
import '../data/repositories/auth.dart';
import '../domain/usecases/notify_api.dart';
import '../domain/usecases/register_account.dart';
import '../external/api/api_external.dart';
import '../external/firebase/auth_firebase.dart';

final googleSignIn = GoogleSignIn();
final firebaseInstance = FirebaseAuth.instance;
final storage = CustumLocalStorage.instance.storage;
final authFirebase =
    AuthFirebase(firebaseAuth: firebaseInstance, googleSignIn: googleSignIn);
final authRepository = Auth(authDatasource: authFirebase);
final registerAccountUsecase = RegisterAccount(authRepository: authRepository);

final dio = CustumDio.instance;
final apiDatasource = ApiExternal(dio, storage);
final apiRepository = Api(apiDatasource: apiDatasource);
final notifyApiUsecase = NotifyApi(apiRepository: apiRepository);
