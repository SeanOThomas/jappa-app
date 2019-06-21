import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:jaap/data/data_util.dart';
import 'package:jaap/data/dto/meditation.dart';
import 'package:jaap/data/dto/meditation_list.dart';
import 'package:jaap/data/services/local_service.dart';
import 'package:jaap/data/services/remote_service.dart';
import 'package:jaap/domain/models/base_model.dart';
import 'package:jaap/domain/state/med_list_state.dart';

const int NUM_ONE_MINUTE_REMINDERS = 4;
const int NUM_TWO_MINUTE_REMINDERS = 3;

class MedListModel<MedListState> extends BaseModel {
  final _remoteService = RemoteService();
  final _localService = LocalService();
  final _random = Random();

  MeditationList medList;
  Meditation audioMed;
  AudioState audioState;
  Timer reminderCountdown;

  MedListModel(state) : super(state);

  void onStartMed() {
    print("onStartMed");
    audioState = AudioState();
    _getIntro().then((file) {
      setState(PlayAudio(file));
    });
  }

  void onAudioComplete() {
    print("onAudioComplete");
    if (audioState.didPlayDescription) {
      print("setting timer, num reminders: ${audioState.numRemindersPlayed}");
      if (audioState.numRemindersPlayed < NUM_ONE_MINUTE_REMINDERS) {
        // set timer for 1 minute
        reminderCountdown = Timer(Duration(minutes: 1), () {
          _getNextReminder(audioMed.key, audioMed.numReminders).then((file) {
            setState(PlayAudio(file));
          });
        });
      } else if (audioState.numRemindersPlayed < NUM_TWO_MINUTE_REMINDERS) {
        // set timer for 2 minutes
        reminderCountdown = Timer(Duration(minutes: 2), () {
          _getNextReminder(audioMed.key, audioMed.numReminders).then((file) {
            setState(PlayAudio(file));
          });
        });
      } else {
        // set timer for 3 minutes
        reminderCountdown = Timer(Duration(minutes: 3), () {
          _getNextReminder(audioMed.key, audioMed.numReminders).then((file) {
            setState(PlayAudio(file));
          });
        });
      }
      audioState.numRemindersPlayed += 1;
    } else {
      // play description
      audioState.didPlayDescription = true;
      _getDescription(audioMed.key).then((file) {
        setState(PlayAudio(file));
      });
    }
  }

  Future<MeditationList> init() async {
    return _remoteService.fetchMeditationList().then((snapshot) async {
      medList = MeditationList.fromJson(snapshot.data);
      setState(Results);

      final medListLocal = await _localService.getMedList();
      if (medListLocal != null) {
        if (medListLocal.version == medList.version) {
          print('remote version is the same, no audio to fetch');
          setState(ResultsWithAudio());
        } else if (medListLocal.version[0] == medList.version[0]) {
          print('version decimal is different, fetch audio without intro');
          _remoteService.fetchAudio(medList).then((_) {
            setState(ResultsWithAudio());
          });
        } else {
          print('version integer is different, fetch all audio');
          _remoteService.fetchAudio(medList, _remoteService.fetchIntroMed()).then((_) {
            setState(ResultsWithAudio());
          });
        }
      } else {
        print('no saved med list, fetch all audio');
        _remoteService.fetchAudio(medList, _remoteService.fetchIntroMed()).then((_) {
          setState(ResultsWithAudio());
        });
      }
      // store remote med list
      _localService.saveMedList(json.encode(snapshot.data));
      return medList;
    });
  }

  Future<File> _getIntro() {
    return _localService.getAppStorageFile(DataUtil.getIntroMedFileName());
  }

  Future<File> _getDescription(String medKey) {
    return _localService.getAppStorageFile(DataUtil.getMedDescriptionFileName(medKey));
  }

  Future<File> _getNextReminder(String medKey, int numMeditations) {
    int remNum = 1 + _random.nextInt(numMeditations);
    return _localService.getAppStorageFile(DataUtil.getMedReminderFileName(medKey, remNum));
  }

  void onMedSelected(Meditation med) { audioMed = med; }

  @override
  void dispose() {
    if (reminderCountdown != null) {
      reminderCountdown.cancel();
    }
    super.dispose();
  }
}
