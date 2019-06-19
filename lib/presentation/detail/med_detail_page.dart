import 'dart:async';

import 'package:audioplayer/audioplayer.dart';
import 'package:flutter/widgets.dart';
import 'package:jaap/data/dto/meditation.dart';
import 'package:jaap/domain/models/med_list_model.dart';
import 'package:jaap/domain/state/med_list_state.dart';
import 'package:provider/provider.dart';

import '../error_message.dart';
import '../loading_spinner.dart';

class MedDetailPage extends StatefulWidget {
  static const ROUTE_NAME = '/detail';

  final Meditation med;

  const MedDetailPage({Key key, this.med}) : super(key: key);

  @override
  _MedDetailPageState createState() => _MedDetailPageState(med);
}

class _MedDetailPageState extends State<MedDetailPage> {

  final Meditation med;
  bool didPlayIntro = false;
  bool didPlayDescription = false;
  int numRemindersPlayed = 0;

  final audioPlayer = AudioPlayer();
  Timer timer;

  _MedDetailPageState(this.med);

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<MedListModel>(context);
    return _getWidget(model);
  }

  Widget _getWidget(MedListModel model) {
    switch (model.state) {
      case ResultsWithAudio:
        {
          return Center(child: Text(MedDetailPage.ROUTE_NAME));
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
  void playNextFile() {

  }
}
