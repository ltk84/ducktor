import 'dart:developer';
import 'dart:io';

import 'package:ducktor/common/local_storage/local_storage_client.dart';
import 'package:flutter/foundation.dart';
import 'package:socket_io_client/socket_io_client.dart';

import '../chat_stream.dart';
import '../model/message.dart';
import '../model/response.dart';

class ChatbotViewModel {
  // Change to your PC's IPv4
  final Socket _socket = io('http://192.168.1.85:5004/',
      OptionBuilder().setTransports(['websocket']).build());

  String currentEvent = 'message';
  final ChatStream _chatStream = ChatStream();
  final localStorageClient = LocalStorageClient();

  ChatStream get chatStream => _chatStream;

  void connectToSocketIO() {
    _socket.onConnect((data) => log('Client connected!'));
    _socket.onDisconnect((data) => log('Client disconnect!'));
    _socket.onConnectError((data) => log('error $data'));
    _socket.onConnecting((data) => log('connecting...'));
    _socket.onConnectTimeout((data) => log('timeout'));

    _socket.on(currentEvent, (data) {
      final response = Response.fromMap(data);
      if (response.nextEvent.isNotEmpty && currentEvent != response.nextEvent) {
        currentEvent = response.nextEvent;
      }
      log('Client receive: ${response.toString()}');
      final serverMessage = Message(
          id: UniqueKey().hashCode.toString(),
          author: Author.server,
          content: response.content,
          dateTime: DateTime.now());
      _chatStream.addResponse([serverMessage]);
      saveNewMessageToChatHistory(serverMessage.toJson());
    });

    // socket.on(SocketIOEvent.diseasePrediction, (data) {
    //   final response = Response.fromMap(data);
    //   if (response.nextEvent.isNotEmpty && currentEvent != response.nextEvent) {
    //     currentEvent = response.nextEvent;
    //   }
    //   _chatStream.addResponse(
    //       Message(author: Author.server, content: response.content));
    // });

    // socket.on(SocketIOEvent.receiveSymptoms, (data) {
    //   final response = Response.fromMap(data);
    //   if (response.nextEvent.isNotEmpty && currentEvent != response.nextEvent) {
    //     currentEvent = response.nextEvent;
    //   }
    //   _chatStream.addResponse(
    //       Message(author: Author.server, content: response.content));
    // });

    // socket.on(SocketIOEvent.diseaseInformation, (data) {
    //   final response = Response.fromMap(data);
    //   if (response.nextEvent.isNotEmpty && currentEvent != response.nextEvent) {
    //     currentEvent = response.nextEvent;
    //   }
    //   log(response.toString());
    //   _chatStream.addResponse(
    //       Message(author: Author.server, content: response.content));
    // });
  }

  void sendMessage(String message) {
    final newMessage = Message(
        id: UniqueKey().hashCode.toString(),
        author: Author.client,
        content: message,
        dateTime: DateTime.now());
    _chatStream.addResponse([newMessage]);
    saveNewMessageToChatHistory(newMessage.toJson());
    _socket.emit(currentEvent, message);
  }

  Future<void> loadChatHistory() async {
    final contents = await localStorageClient.readFromChatHistoryFile();
    List<Message> messages = contents.map((e) => Message.fromJson(e)).toList();
    messages.sort(((a, b) => b.dateTime.compareTo(a.dateTime)));
    _chatStream.addResponse(messages);
  }

  Future<void> saveNewMessageToChatHistory(String newMessage) async {
    await localStorageClient.writeToChatHistoryFile(newMessage);
  }
}
