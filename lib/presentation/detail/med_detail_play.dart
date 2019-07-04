import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:jappa/domain/models/med_list_model.dart';
import 'package:jappa/domain/state/med_list_state.dart';
import 'package:provider/provider.dart';

import '../styles.dart';

class MedDetailPlay extends StatelessWidget {

  final AudioPlayer audioPlayer;

  const MedDetailPlay({Key key, this.audioPlayer}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<MedListModel>(context);
    return WillPopScope(
      onWillPop: () {
        Provider.of<MedListModel>(context).onCleanMed();
        Navigator.pop(context);
      },
      child: Scaffold(
        body: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: PADDING_DEFAULT),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  IconButton(
                    icon: Icon(Icons.arrow_back),
                    color: Theme.of(context).accentColor,
                    onPressed: () {
                      Provider.of<MedListModel>(context).onCleanMed();
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Text("Vrindavan sounds"),
                Switch(
                  value: model.audioState.bgEnabled,
                  onChanged: (value) {
                    model.onToggleBg();
                  },
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Text("Focus reminders"),
                Switch(
                  value: model.audioState.remindersEnabled,
                  onChanged: (value) {
                    model.onToggleReminders();
                  },
                ),
              ],
            ),
            Flexible(
              child: Stack(
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Flexible(
                        child: Container(
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: PADDING_DEFAULT),
                              child: Text(model.audioMed.title, style: Theme.of(context).textTheme.display1),
                            ),
                          ),
                        ),
                        flex: 1,
                      ),
                      Flexible(
                        child: Container(
                          color: getTypeColor(model.audioMed.type),
                          child: Center(child: _skipButtonIfNecessary(context, model)),
                        ),
                        flex: 1,
                      ),
                    ],
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: FloatingActionButton(
                      child: Icon(model.audioState.isPlayerPaused ? Icons.play_arrow : Icons.pause),
                      onPressed: () {
                        model.onTogglePause();
                      },
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _skipButtonIfNecessary(BuildContext context, MedListModel model) {
    var playType = model.audioState.playType;
    if (playType == PlayType.INTRO || playType == PlayType.DESC) {
      return FlatButton(
        child: Padding(
          padding: const EdgeInsets.all(14.0),
          child: Text(
            playType == PlayType.INTRO  ? "Skip Intro" : "Skip Description",
            style: TextStyle(color: Theme.of(context).primaryColor, fontStyle: FontStyle.italic, fontSize: 18),
          ),
        ),
        shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
        onPressed: () {
          audioPlayer.seek(Duration(days: 1)); // this effectively skips the track
          if (model.audioState.isPlayerPaused) {
            model.onTogglePause();
          }
        },
      );
    } else {
      return Text(""); // return an empty view
    }
  }
}
