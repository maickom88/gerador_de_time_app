import 'dart:async';

class CustumFilePicker {
  static final StreamController<double> _progress = StreamController<double>();
  Stream<double> onProgress = _progress.stream.asBroadcastStream();

  CustumFilePicker._run();
  static final CustumFilePicker _singleton = CustumFilePicker._run();
  static CustumFilePicker get instance => _singleton;

  factory CustumFilePicker() => _singleton;

  void setValueProgress(double progress) {
    _progress.add(progress);
  }
}
