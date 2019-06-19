import 'dart:convert';
import 'dart:io';

import 'package:jaap/data/data_constants.dart';
import 'package:jaap/data/dto/meditation_list.dart';
import 'package:jaap/data/services/remote_service.dart';
import 'package:jaap/domain/models/base_model.dart';
import 'package:jaap/domain/state/med_list_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MedListModel<MedListState> extends BaseModel {
  MeditationList medList;

  final _remoteService = RemoteService();

  MedListModel(state) : super(state);

  Future<MeditationList> init() async {
    return _remoteService.fetchMeditationList().then((snapshot) async {
      medList = MeditationList.fromJson(snapshot.data);
      setState(Results);

      // determine what we should fetch based on remote version against
      // local version.
      final prefs = await SharedPreferences.getInstance();
      final medListLocalJson = prefs.get(DataConstants.KEY_MED_LIST);
      if (medListLocalJson != null) {
        final medListLocal = MeditationList.fromJson(json.decode(medListLocalJson));
        if (medListLocal.version == medList.version) {
          print('remote version is the same, no audio to fetch');
          setState(ResultsWithAudio);
        } else if (medListLocal.version[0] == medList.version[0]) {
          print('version decimal is different, fetch audio without intro');
          _remoteService.fetchAudio(medList).then((_) {
            setState(ResultsWithAudio);
          });
        } else {
          print('version integer is different, fetch all audio');
          _remoteService.fetchAudio(medList, _remoteService.fetchIntroMed()).then((_) {
            setState(ResultsWithAudio);
          });
        }
      } else {
        print('no saved med list, fetch all audio');
        _remoteService.fetchAudio(medList, _remoteService.fetchIntroMed()).then((_) {
          setState(ResultsWithAudio);
        });
      }
      // store remote med list
      prefs.setString(DataConstants.KEY_MED_LIST, json.encode(snapshot.data));
      return medList;
    });
  }


  Future<File> getIntro() {
    return null;
  }

  Future<File> getDescription(String medKey) {
    return null;
  }


  Future<File> getReminder(String medKey) {
    return null;
  }

//    File file = File("NA");
//    AudioPlayer audioPlayer = AudioPlayer();
//    audioPlayer.play(file.path, isLocal: true);
}
