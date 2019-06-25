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
  bool didStartDescription = false;
  bool didCompleteDescription = false;
  bool didLoopBg = false;
  bool remindersEnabled = true;
  bool bgEnabled = true;
  bool isPaused = false;
  int numRemindersPlayed = 0;
}