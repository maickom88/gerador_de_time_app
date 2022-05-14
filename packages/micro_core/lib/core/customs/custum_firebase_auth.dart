import 'package:firebase_auth/firebase_auth.dart';

class CustumFirebaseAuth {
  static bool userISLogged() {
    if (FirebaseAuth.instance.currentUser != null) {
      return true;
    }
    return false;
  }

  static Future<String> getToken() async {
    if (userISLogged()) {
      return await FirebaseAuth.instance.currentUser!.getIdToken(true);
    }
    return '';
  }
}
