import 'package:firebase_auth/firebase_auth.dart';

import '../custum_google_auth.dart';
import '../data/repositories/auth.dart';
import '../domain/usecases/login_email_with_password.dart';
import '../domain/usecases/login_social_usecase.dart';
import '../external/firebase/auth_firebase.dart';

final googleSignIn = CustumGoogleAuth.instance;
final firebaseInstance = FirebaseAuth.instance;
final authFirebase = AuthFirebase(
    firebaseAuth: firebaseInstance, custumGoogleAuth: googleSignIn);
final authRepository = Auth(authDatasource: authFirebase);
final loginSocialUsecase = LoginWithSocial(authRepository: authRepository);
final loginWithEmailAndPasswordUsecase =
    LoginWithEmailAndPassword(authRepository: authRepository);
