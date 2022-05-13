import 'package:google_sign_in/google_sign_in.dart';

class CustumGoogleAuth {
  late GoogleSignIn googleSignIn;

  CustumGoogleAuth._run();
  static final CustumGoogleAuth _singleton = CustumGoogleAuth._run();
  static CustumGoogleAuth get instance => _singleton;
  factory CustumGoogleAuth() => _singleton;

  Future<void> initialize() async {
    googleSignIn = GoogleSignIn();
  }
}
