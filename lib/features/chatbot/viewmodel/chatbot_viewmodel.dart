import 'dart:developer';

import 'package:ducktor/common/local_storage/local_storage_client.dart';
import 'package:ducktor/common/utilities/message_action_utility.dart';
import 'package:ducktor/features/chatbot/tts_client.dart';
import 'package:ducktor/features/chatbot/typing_stream.dart';
import 'package:ducktor/features/reminder/model/reminder_info.dart';
import 'package:ducktor/features/reminder/model/reminder_setting.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
  late TextToSpeechClient ttsClient;

  ChatbotViewModel() {
    String host = dotenv.env['HOST'] ?? '';
    String port = dotenv.env['PORT'] ?? '';
    _socket = io('http://$host:$port/',
        OptionBuilder().setTransports(['websocket']).build());
    ttsClient = TextToSpeechClient();
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

    _socket.on('content_for_voice', (data) async {
      await ttsClient.speak(data);
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

  void sendServerMessage(String message,
      {MessageAction action = MessageAction.none}) async {
    final serverMessage = Message(
      id: UniqueKey().hashCode.toString(),
      author: Author.server,
      content: message,
      dateTime: DateTime.now(),
      action: action,
    );
    _chatStream.addResponse([serverMessage]);
    handleSuggestMessages([]);
    saveNewMessageToChatHistory(serverMessage.toJson());
    await ttsClient.speak(message);
  }

  void addReminderInfo(
    String title,
    String message,
    ReminderSetting setting,
  ) async {
    List<DateTime> dates = [setting.fromDate];

    // Calculate noti-reminder dates
    if (setting.toDate == null) {
      int timeCount = setting.times!;
      var currentTime = setting.fromDate;
      while (timeCount != 0) {
        currentTime =
            currentTime.add(Duration(days: countFreq(setting, currentTime)));
        dates.add(currentTime);
        timeCount--;
      }
    } else if (setting.times == null) {
      var currentTime = setting.fromDate;
      while (true) {
        currentTime =
            currentTime.add(Duration(days: countFreq(setting, currentTime)));
        if (!currentTime.isAfter(setting.toDate!)) {
          dates.add(currentTime);
        } else {
          break;
        }
      }
    }

    // Save noti-reminder dates
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<ReminderInfo> reminderInfo = prefs
            .getStringList('reminders')
            ?.map((e) => ReminderInfo.fromJson(e))
            .toList() ??
        [];

    reminderInfo.addAll(dates
        .map((e) => ReminderInfo(title: title, message: message, dateTime: e)));
    prefs.setStringList(
        'reminders', reminderInfo.map((e) => e.toJson()).toList());
  }

  int countFreq(ReminderSetting setting, DateTime currentTime) {
    int freq;

    switch (setting.frequency) {
      case Frequency.daily:
        freq = setting.freqNum;
        break;
      case Frequency.weekly:
        freq = 7 * setting.freqNum;
        break;
      case Frequency.monthly:
        int dayOfMonth =
            DateTime(currentTime.year, currentTime.month + 1, 0).day;
        freq = dayOfMonth * setting.freqNum;
        break;
      case Frequency.yearly:
        bool isLeap = DateTime(currentTime.year, 3, 0).day == 29;
        int dayOfYear = isLeap ? 366 : 365;
        freq = dayOfYear * setting.freqNum;
        break;
    }

    return freq;
  }
}
