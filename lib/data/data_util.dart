import 'dart:io';

import 'package:path_provider/path_provider.dart';

import 'data_constants.dart';

class DataUtil {

  static String getIntroMedFileName() {
    return _plusFileExt(DataConstants.FILE_NAME_INTRO_MEDITATION);
  }

  static String getMedDescriptionFileName(String medKey) {
    _plusFileExt('$medKey/${DataConstants.FILE_NAME_DESCRIPTION}');
  }

  static String getMedReminderFileName(String medKey, int num) {
    return _plusFileExt('$medKey/${DataConstants.FILE_NAME_REMINDER}$num');
  }

  /// Gets a file in private app storage.
  ///
  /// Takes  a file name, eg "intro_med.mp3",  "1/desc.mp3" or
  /// "1/rem3.mp3"
  static Future<File> getAppStorageFile(String fileName) async {
    final path = await _getAppStoragePath();
    return File('$path/$fileName').create(recursive: true);
  }

  /// Get path to private app storage.
  static Future<String> _getAppStoragePath() async {
    final dir = await getApplicationDocumentsDirectory();
    return dir.path;
  }

  static String _plusFileExt(String fileName) => '$fileName.mp3';
}