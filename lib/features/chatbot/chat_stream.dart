import 'dart:async';

import 'package:ducktor/features/chatbot/message.dart';

class ChatStream {
  final _socketResponse = StreamController<Message>();

  void Function(Message) get addResponse => _socketResponse.sink.add;

  Stream<Message> get getResponse => _socketResponse.stream;

  void dispose() {
    _socketResponse.close();
  }
}
