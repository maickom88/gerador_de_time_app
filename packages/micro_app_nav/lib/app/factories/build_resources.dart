import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:micro_core/core/customs/custum_dio.dart';
import 'package:micro_core/core/customs/custum_local_storage.dart';

import '../data/repositories/api.dart';
import '../data/repositories/auth.dart';
import '../domain/usecases/get_players_usecase.dart';
import '../domain/usecases/get_sports_usecase.dart';
import '../domain/usecases/logout_usecase.dart';
import '../external/api/api_external.dart';
import '../external/firebase/auth_firebase.dart';

final googleSignIn = GoogleSignIn();
final storage = CustumLocalStorage.instance.storage;
final firebaseInstance = FirebaseAuth.instance;
final authFirebase =
    AuthFirebase(firebaseAuth: firebaseInstance, googleSignIn: googleSignIn);
final authRepository = Auth(authDatasource: authFirebase);
final logoutUsecase = Logout(authRepository: authRepository);
final dio = CustumDio.instance;
final apiDatasource = ApiExternal(dio);
final apiRepository = Api(apiDatasource: apiDatasource);
final getSportsUsecase = GetSports(apiRepository: apiRepository);
final getPlayersUsecase = GetPlayers(apiRepository: apiRepository);
