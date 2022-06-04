import "dart:math";

class LocalImage {
  static const String error2 = 'assets/animations/error2.json';
  static const String sportLottie = 'assets/animations/load_sport.json';
}

class ProfileImage {
  static const String hand1 = 'assets/images/hand1.png';
  static const String hand2 = 'assets/images/hand2.png';
  static const String hand3 = 'assets/images/hand3.png';
  static const String hand4 = 'assets/images/hand4.png';
  static const String hand5 = 'assets/images/hand5.png';
  static const String hand6 = 'assets/images/hand6.png';

  static String generateImage() {
    final random = Random();
    final list = [hand1, hand2, hand3, hand4, hand5, hand6];
    final image = list[random.nextInt(list.length)];
    return image;
  }
}
