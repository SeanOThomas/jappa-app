import 'dart:io';

import 'package:path_provider/path_provider.dart';

class LocalService {

  /// Gets a file in private app storage.
  ///
  /// Takes  a file name, eg "intro_med.mp3",  "1/desc.mp3" or
  /// "1/rem3.mp3"
  Future<File> getAppStorageFile(String fileName) async {
    final path = await _getAppStoragePath();
    return File('$path/$fileName').create(recursive: true);
  }

  /// Get path to private app storage.
  Future<String> _getAppStoragePath() async {
    final dir = await getApplicationDocumentsDirectory();
    return dir.path;
  }
}