extension LockEamil on String {
  String lockEmail() {
    // ignore: unnecessary_this
    final email = this.split('@').first;
    int numSpace = email.length - 3;
    // ignore: unnecessary_this
    String result = this.replaceRange(0, numSpace, '*' * numSpace);
    return result;
  }
}
