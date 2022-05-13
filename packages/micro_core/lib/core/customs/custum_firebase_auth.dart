import 'package:firebase_auth/firebase_auth.dart';

import '../errors/errors.dart';

class CustumFirebaseAuth {
  static bool userISLogged() {
    if (FirebaseAuth.instance.currentUser != null) {
      return true;
    }
    return false;
  }

  static Future<String> getToken() async {
    if (FirebaseAuth.instance.currentUser != null) {
      return await FirebaseAuth.instance.currentUser!.getIdToken(true);
    }
    throw Unauthorized();
  }
}
