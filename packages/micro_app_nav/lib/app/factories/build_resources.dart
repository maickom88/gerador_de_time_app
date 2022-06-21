import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:micro_core/core/customs/custum_dio.dart';

import '../data/repositories/api.dart';
import '../data/repositories/auth.dart';
import '../domain/usecases/clear_notification.dart';
import '../domain/usecases/get_cup_information_usecase.dart';
import '../domain/usecases/get_cups_usecase.dart';
import '../domain/usecases/get_notifications.dart';
import '../domain/usecases/get_positions_usecase.dart';
import '../domain/usecases/get_sports_usecase.dart';
import '../domain/usecases/logout_usecase.dart';
import '../domain/usecases/remove_players_usecase.dart';
import '../domain/usecases/save_player_usecase.dart';
import '../domain/usecases/save_skill_usecase.dart';
import '../domain/usecases/update_user.dart';
import '../external/api/api_external.dart';
import '../external/firebase/auth_firebase.dart';

final googleSignIn = GoogleSignIn();
final firebaseInstance = FirebaseAuth.instance;
final authFirebase =
    AuthFirebase(firebaseAuth: firebaseInstance, googleSignIn: googleSignIn);
final authRepository = Auth(authDatasource: authFirebase);
final logoutUsecase = Logout(authRepository: authRepository);
final dio = CustumDio.instance;
final apiDatasource = ApiExternal(dio);
final apiRepository = Api(apiDatasource: apiDatasource);
final getSportsUsecase = GetSports(apiRepository: apiRepository);
final savePLayer = SavePlayer(apiRepository: apiRepository);
final getPositions = GetPositions(apiRepository: apiRepository);
final saveSkill = SaveSkill(apiRepository: apiRepository);
final removerPLayers = RemovePlayers(apiRepository: apiRepository);
final getCupsUsecase = GetCups(apiRepository: apiRepository);
final updateUser = UpdateUser(apiRepository: apiRepository);
final getNotificationsUsecase = GetNotifications(apiRepository: apiRepository);
final clearNotificationsUsecase =
    ClearNotification(apiRepository: apiRepository);
final getCupInformationUsecase =
    GetCupInformation(apiRepository: apiRepository);
