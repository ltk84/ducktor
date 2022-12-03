import 'dart:developer';

import 'package:ducktor/common/local_storage/local_storage_client.dart';
import 'package:ducktor/common/utilities/message_action_utility.dart';
import 'package:ducktor/features/chatbot/typing_stream.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:geolocator/geolocator.dart';
import 'package:socket_io_client/socket_io_client.dart';

import '../chat_stream.dart';
import '../model/message.dart';
import '../model/response.dart';

class ChatbotViewModel {
  // Change to your PC's IPv4
  late Socket _socket;

  String currentEvent = 'message';
  final ChatStream _chatStream = ChatStream();
  final TypingStream _typingStream = TypingStream();
  final List<String> suggestMessages = [];
  final localStorageClient = LocalStorageClient();

  ChatbotViewModel() {
    String host = dotenv.env['HOST'] ?? '';
    String port = dotenv.env['PORT'] ?? '';
    _socket = io('http://$host:$port/',
        OptionBuilder().setTransports(['websocket']).build());
  }

  ChatStream get chatStream => _chatStream;
  TypingStream get typingStream => _typingStream;

  void connectToSocketIO() {
    _socket.onConnect((data) => log('Client connected!'));
    _socket.onDisconnect((data) => log('Client disconnect!'));
    _socket.onConnectError((data) => log('error $data'));
    _socket.onConnecting((data) => log('connecting...'));
    _socket.onConnectTimeout((data) => log('timeout'));

    _socket.on('in_progress', (data) {
      _typingStream.addEvent(data);
    });

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
        dateTime: DateTime.now(),
        extraData: response.extraData,
        action: MessageActionUtility.getActionByCode(response.actionCode),
      );

      handleSuggestMessages(response.suggestMessages ?? []);
      _chatStream.addResponse([serverMessage]);
      saveNewMessageToChatHistory(serverMessage.toJson());
      handleNextAction(response.actionCode);
    });
  }

  void handleSuggestMessages(List<String> suggestMessages) {
    this.suggestMessages.clear();
    if (suggestMessages.isNotEmpty) {
      this.suggestMessages.addAll(suggestMessages);
    }
  }

  void handleNextAction(String actionCode) {
    MessageAction action = MessageActionUtility.getActionByCode(actionCode);

    switch (action) {
      case MessageAction.askForPosition:
        handleAskForPosition();
        break;
      default:
        break;
    }
  }

  void handleAskForPosition() async {
    bool serviceEnabled;
    LocationPermission permission = await Geolocator.checkPermission();
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (serviceEnabled) {
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }

      if (permission != LocationPermission.denied &&
          permission != LocationPermission.deniedForever) {
        Position position = await Geolocator.getCurrentPosition();
        Map<String, dynamic> data = {
          "lat": position.latitude,
          "lon": position.longitude
        };
        _socket.emit("location_sent", data);
        return;
      }
    }

    _socket.emit("no_location_sent");
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
