import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../data/datasources/auth_datasource.dart';
import '../../data/errors/failures.dart';
import '../../data/errors/login_cancel_error.dart';
import '../../domain/entities/auth_response.dart';

class AuthFirebase implements AuthDatasource {
  final GoogleSignIn googleSignIn;
  final FirebaseAuth firebaseAuth;
  AuthFirebase({
    required this.googleSignIn,
    required this.firebaseAuth,
  });

  @override
  Future<AuthResponse> loginWithApple() {
    throw UnimplementedError();
  }

  @override
  Future<AuthResponse> loginWithGoogle() async {
    try {
      final googleSignInAccount = await googleSignIn.signIn();
      if (googleSignInAccount != null) {
        final googleSignInAuthentication =
            await googleSignInAccount.authentication;
        final credential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken,
        );
        return _signInWithCredential(credential);
      }
      throw LoginCancel();
    } on FirebaseAuthException catch (e) {
      throw firebaseHandlersErrors(typeError: e);
    } on Exception catch (e) {
      throw firebaseHandlersErrors(typeError: e);
    }
  }

  Future<AuthResponse> _signInWithCredential(AuthCredential credential) async {
    final userCredential = await firebaseAuth.signInWithCredential(credential);
    return await _saveToken(userCredential);
  }

  Future<AuthResponse> _saveToken(UserCredential userCredential) async {
    final authResponse = await AuthResponse().fromCredential(userCredential);
    return authResponse;
  }

  @override
  Future<AuthResponse> loginWithEmailAndPassword(
      String email, String password) async {
    try {
      final userCredential = await firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return await _saveToken(userCredential);
    } on FirebaseAuthException catch (e) {
      throw firebaseHandlersErrors(typeError: e);
    } on Exception catch (e) {
      throw firebaseHandlersErrors(typeError: e);
    }
  }

  @override
  Future<void> logout() async {
    try {
      await firebaseAuth.signOut();
      await googleSignIn.signOut();
    } on FirebaseAuthException catch (e) {
      throw firebaseHandlersErrors(typeError: e);
    } on Exception catch (e) {
      throw firebaseHandlersErrors(typeError: e);
    }
  }

  @override
  Future<void> sendEmailVerification(String email, String password) async {
    try {
      final userCredential = await firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      await userCredential.user?.sendEmailVerification();
      await logout();
      return;
    } on FirebaseAuthException catch (e) {
      throw firebaseHandlersErrors(typeError: e);
    } on Exception catch (e) {
      throw firebaseHandlersErrors(typeError: e);
    }
  }
}
