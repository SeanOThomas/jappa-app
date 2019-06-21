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

// mutable audio state
class AudioState {
  bool didPlayDescription = false;
  int numRemindersPlayed = 0;
}