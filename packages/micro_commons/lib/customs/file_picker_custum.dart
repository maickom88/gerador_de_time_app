import 'dart:async';

class CustumFilePicker {
  static final StreamController<double> _progress = StreamController<double>();
  Stream<double> onProgress = _progress.stream.asBroadcastStream();

  CustumFilePicker._run();
  static final CustumFilePicker _singleton = CustumFilePicker._run();
  static CustumFilePicker get instance => _singleton;

  factory CustumFilePicker() => _singleton;

  Future<void> setValueProgress(double progress) async {
    if (!_progress.isClosed) {
      _progress.add(progress);
    }
  }

  Future<void> closeStream() async {
    await _progress.close();
  }
}
