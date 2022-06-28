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
      return await FirebaseAuth.instance.currentUser!.getIdToken();
    }
    return '';
  }

  static Future<void> logout() async {
    await FirebaseAuth.instance.signOut();
  }
}
