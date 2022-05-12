import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../data/repositories/auth.dart';
import '../domain/usecases/login_email_with_password.dart';
import '../domain/usecases/login_social_usecase.dart';
import '../external/firebase/auth_firebase.dart';

final googleSignIn = GoogleSignIn();
final firebaseInstance = FirebaseAuth.instance;
final authFirebase =
    AuthFirebase(firebaseAuth: firebaseInstance, googleSignIn: googleSignIn);
final authRepository = Auth(authDatasource: authFirebase);
final loginSocialUsecase = LoginWithSocial(authRepository: authRepository);
final loginWithEmailAndPasswordUsecase =
    LoginWithEmailAndPassword(authRepository: authRepository);
