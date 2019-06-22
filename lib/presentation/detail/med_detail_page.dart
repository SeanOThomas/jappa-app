import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:jaap/domain/models/med_list_model.dart';
import 'package:jaap/domain/state/med_list_state.dart';
import 'package:provider/provider.dart';

import '../error_message.dart';
import '../loading_spinner.dart';

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
      final model = Provider.of<MedListModel>(context);
      model.onAudioComplete();
    });

    bgPlayer.onPlayerCompletion.listen((_) {
      bgPlayer.seek(Duration()); // seek to the beginning to loop
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print("build ${MedDetailPage.ROUTE_NAME}");

    final model = Provider.of<MedListModel>(context);
    return _getWidget(model);
  }

  Widget _getWidget(MedListModel model) {
    print("_getWidget with ${model.state}");
    switch (model.state.runtimeType) {
      case LoopBg: {
        File audioFile = (model.state as LoopBg).file;
        bgPlayer.play(audioFile.path, isLocal: true);
        return Scaffold(
          body: Center(
            child: Text("playing ${audioFile.path}"),
          ),
        );
      }
      case PlayAudio:
        File audioFile = (model.state as PlayAudio).file;
        audioPlayer.play(audioFile.path, isLocal: true);
        return Scaffold(
          body: Center(
            child: Text("playing ${audioFile.path}"),
          ),
        );
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
