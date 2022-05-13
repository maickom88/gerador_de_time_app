import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../data/repositories/auth.dart';
import '../domain/usecases/logout_usecase.dart';
import '../external/firebase/auth_firebase.dart';

final googleSignIn = GoogleSignIn();
final firebaseInstance = FirebaseAuth.instance;
final authFirebase =
    AuthFirebase(firebaseAuth: firebaseInstance, googleSignIn: googleSignIn);
final authRepository = Auth(authDatasource: authFirebase);
final logoutUsecase = Logout(authRepository: authRepository);
