import 'dart:convert';

import '../../../common/utilities/message_action_utility.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first
enum Author { server, client }

class Message {
  final String id;
  final Author author;
  final String content;
  final DateTime dateTime;
  final MessageAction action;

  Message({
    required this.id,
    required this.author,
    required this.content,
    required this.dateTime,
    this.action = MessageAction.none,
  });

  bool get isClientMessage => author == Author.client;

  // Không có trường suggestMessage vì không muốn local storage lưu nó => Vì nó k cần thiết
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'author': author.index,
      'content': content,
      'dateTime': dateTime.toString(),
      'action': action.index,
    };
  }

  factory Message.fromMap(Map<String, dynamic> map) {
    return Message(
      id: map['id'] ?? '',
      author: map['author'] == 0 ? Author.server : Author.client,
      content: map['content'] ?? '',
      dateTime: DateTime.parse(map['dateTime'] ?? "2001-01-01"),
      action: MessageActionUtility.getAction(map['action']),
    );
  }

  String toJson() => json.encode(toMap());

  factory Message.fromJson(String source) =>
      Message.fromMap(json.decode(source) as Map<String, dynamic>);
}
