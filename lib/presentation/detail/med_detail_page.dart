import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:jaap/domain/models/med_list_model.dart';
import 'package:jaap/domain/state/med_list_state.dart';
import 'package:provider/provider.dart';

import '../error_message.dart';
import '../loading_spinner.dart';
import 'med_detail_play.dart';

class MedDetailPage extends StatefulWidget {
  static const ROUTE_NAME = '/detail';

  @override
  _MedDetailPageState createState() => _MedDetailPageState();
}

class _MedDetailPageState extends State<MedDetailPage> {
  final audioPlayer = AudioPlayer();
  final bgPlayer = AudioPlayer();

  @override
  void initState() {
    print("initState ${MedDetailPage.ROUTE_NAME}");

    audioPlayer.onPlayerCompletion.listen((_) {
      Provider.of<MedListModel>(context).onAudioComplete();
    });
    bgPlayer.setReleaseMode(ReleaseMode.LOOP);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print("build ${MedDetailPage.ROUTE_NAME}");
    return _getWidget(Provider.of<MedListModel>(context));
  }

  Widget _getWidget(MedListModel model) {
    print("_getWidget with ${model.state}");
    switch (model.state.runtimeType) {
      case LoopBg: {
        File audioFile = (model.state as LoopBg).file;
        bgPlayer.play(audioFile.path, isLocal: true);
        return MedDetailPlay(model.audioMed);
      }
      case PlayAudio:
        File audioFile = (model.state as PlayAudio).file;
        audioPlayer.play(audioFile.path, isLocal: true);
        return MedDetailPlay(model.audioMed);
      case ResumeAudio: {
        audioPlayer.resume();
        bgPlayer.resume();
        return MedDetailPlay(model.audioMed);
      }
      case PauseAudio: {
        audioPlayer.pause();
        bgPlayer.pause();
        return MedDetailPlay(model.audioMed, false);
      }
      case ResultsWithAudio:
        {
          // only start once there's audio results (we could still be fetching on this screen)
          model.onStartMed();
          return LoadingSpinner();
        }
      case Error:
        {
          return ErrorMessage();
        }
      default:
        {
          return LoadingSpinner();
        }
    }
  }

  @override
  void dispose() {
    audioPlayer.stop();
    bgPlayer.stop();
    super.dispose();
  }
}
