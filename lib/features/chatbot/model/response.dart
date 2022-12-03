// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:ducktor/features/chatbot/model/location_data.dart';

class Response {
  final String intent;
  final String content;
  final String nextEvent;
  final String actionCode;
  final LocationData? extraData;
  final List<String>? suggestMessages;

  Response(
      {required this.intent,
      required this.content,
      this.nextEvent = '',
      this.actionCode = '',
      this.extraData,
      this.suggestMessages});

  factory Response.fromMap(Map<String, dynamic> map) {
    print(jsonDecode(map["extra_data"] ?? "{}"));
    return Response(
      intent: map['intent'] ?? '',
      content: map['content'] ?? '',
      nextEvent: map['next_event'],
      actionCode: map['action_code'],
      extraData: LocationData.fromMap(jsonDecode(
          map["extra_data"] == null ? "{}" : jsonDecode(map["extra_data"]))),
      suggestMessages: List<String>.from(map['suggest_messages']),
    );
  }

  @override
  String toString() {
    return 'intent: $intent | content: $content | nextEvent: $nextEvent | actionCode: $actionCode | extraData: $extraData | suggestMessages = $suggestMessages';
  }
}
