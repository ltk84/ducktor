// ignore_for_file: public_member_api_docs, sort_constructors_first
class Response {
  final String intent;
  final String content;
  final String nextEvent;
  final String actionCode;
  final List<String>? suggestMessages;

  Response(
      {required this.intent,
      required this.content,
      this.nextEvent = '',
      this.actionCode = '',
      this.suggestMessages});

  factory Response.fromMap(Map<String, dynamic> map) {
    return Response(
      intent: map['intent'] ?? '',
      content: map['content'] ?? '',
      nextEvent: map['next_event'],
      actionCode: map['action_code'],
      suggestMessages: List<String>.from(map['suggest_messages']),
    );
  }

  @override
  String toString() {
    return 'intent: $intent | content: $content | nextEvent: $nextEvent | actionCode: $actionCode | suggestMessages = $suggestMessages';
  }
}
