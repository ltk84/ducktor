// ignore_for_file: public_member_api_docs, sort_constructors_first
class Response {
  final String intent;
  final String content;
  final String nextEvent;

  Response({required this.intent, required this.content, this.nextEvent = ''});

  factory Response.fromMap(Map<String, dynamic> map) {
    return Response(
        intent: map['intent'] ?? '',
        content: map['content'] ?? '',
        nextEvent: map['next_event'] ?? '');
  }

  @override
  String toString() {
    return 'intent: $intent | content: $content | nextEvent: $nextEvent';
  }
}
