import 'dart:convert';
import 'dart:io';

import 'package:jaap/data/dto/meditation_list.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data_constants.dart';

class LocalService {

  Future<MeditationList> getMedList() async {
    final prefs = await SharedPreferences.getInstance();
    final medListLocalJson = prefs.get(DataConstants.KEY_MED_LIST);
    if (medListLocalJson != null) {
      return MeditationList.fromJson(json.decode(medListLocalJson));
    }
    return null;
  }

  void saveMedList(String medListJson) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(DataConstants.KEY_MED_LIST, medListJson);
  }

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