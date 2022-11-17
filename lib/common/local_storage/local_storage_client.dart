import 'dart:io';

import 'package:path_provider/path_provider.dart';

class LocalStorageClient {
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/ducktor_chat_history.txt');
  }

  Future<void> writeToChatHistoryFile(String newMessage) async {
    final file = await _localFile;
    await file.writeAsString('$newMessage\n', mode: FileMode.append);
  }

  Future<List<String>> readFromChatHistoryFile() async {
    final file = await _localFile;
    final isFileExist = await file.exists();
    if (!isFileExist) {
      await file.create(recursive: true);
    }
    final contents = await file.readAsLines();
    return contents;
  }
}
