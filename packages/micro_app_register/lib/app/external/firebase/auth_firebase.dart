import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../data/datasources/auth_datasource.dart';
import '../../data/errors/failures.dart';
import '../../domain/entities/auth_response.dart';

class AuthFirebase implements AuthDatasource {
  final GoogleSignIn googleSignIn;
  final FirebaseAuth firebaseAuth;
  AuthFirebase({
    required this.googleSignIn,
    required this.firebaseAuth,
  });

  Future<AuthResponse> _saveToken(UserCredential userCredential) async {
    final authResponse = await AuthResponse().fromCredential(userCredential);
    return authResponse;
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

  @override
  Future<AuthResponse> registerAccount(String email, String password) async {
    try {
      final userCredential = await firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      final emailVerified = userCredential.user?.emailVerified ?? false;
      if (!emailVerified) {
        await userCredential.user?.sendEmailVerification();
      }
      return await _saveToken(userCredential);
    } on FirebaseAuthException catch (e) {
      throw firebaseHandlersErrors(typeError: e);
    } on Exception catch (e) {
      throw firebaseHandlersErrors(typeError: e);
    }
  }
}
