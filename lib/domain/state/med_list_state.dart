import 'dart:io';

// fetching state
abstract class MedListState {}
class Loading extends MedListState {}
class Results extends MedListState {}
class ResultsWithAudio extends MedListState {}
class Error extends MedListState {}

// audio state
class PlayAudio extends MedListState {
  final File file;
  PlayAudio(this.file);
}
class LoopBg extends MedListState {
  final File file;
  LoopBg(this.file);
}
class PlayerEvent extends MedListState {}

// mutable audio state
class AudioState {
  // paused state
  bool isPlayerPaused = false;

  // play (or paused) type
  PlayType _playType = PlayType.NONE;
  PlayType get playType => _playType;
  set playType(PlayType playType) {
    if (_playType == PlayType.DESC) {
      _didFinishDesc = true;
    }
    _playType = playType;
  }
  bool _didFinishDesc = false;
  bool get didFinishDesc => _didFinishDesc;

  // reminders
  bool remindersEnabled = true;
  int numRemindersPlayed = 0;

  // bg state
  bool bgEnabled = true;
  bool didStartLoopingBg = false;
  bool shouldResumeBg() {
    return bgEnabled && didStartLoopingBg;
  }
}

enum PlayType {
  INTRO,
  DESC,
  REM,
  NONE
}