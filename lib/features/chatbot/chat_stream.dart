import 'dart:async';

import 'package:ducktor/features/chatbot/model/message.dart';

class ChatStream {
  final _socketResponse = StreamController<List<Message>>();

  void Function(List<Message>) get addResponse => _socketResponse.sink.add;

  Stream<List<Message>> get getResponse => _socketResponse.stream;

  void dispose() {
    _socketResponse.close();
  }
}
