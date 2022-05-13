import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../data/datasources/auth_datasource.dart';
import '../../data/errors/failures.dart';

class AuthFirebase implements AuthDatasource {
  final GoogleSignIn googleSignIn;
  final FirebaseAuth firebaseAuth;
  AuthFirebase({
    required this.googleSignIn,
    required this.firebaseAuth,
  });

  @override
  Future<void> logout() async {
    try {
      await googleSignIn.signOut();
      await firebaseAuth.signOut();
    } on FirebaseAuthException catch (e) {
      throw firebaseHandlersErrors(typeError: e);
    } on Exception catch (e) {
      throw firebaseHandlersErrors(typeError: e);
    }
  }
}
