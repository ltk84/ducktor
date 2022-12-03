import 'dart:async';

class TypingStream {
  final _events = StreamController<bool>();

  void Function(bool) get addEvent => _events.sink.add;

  Stream<bool> get getEvent => _events.stream;

  void dispose() {
    _events.close();
  }
}
