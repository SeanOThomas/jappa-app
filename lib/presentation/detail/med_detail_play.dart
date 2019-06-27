import 'package:flutter/material.dart';
import 'package:jaap/domain/models/med_list_model.dart';
import 'package:provider/provider.dart';

import '../styles.dart';

class MedDetailPlay extends StatelessWidget {

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
                            child: Text(model.audioMed.title,
                                style: Theme.of(context).textTheme.display1),
                          ),
                        ),
                        flex: 1,
                      ),
                      Flexible(
                        child: Container(
                          color: getTypeColor(model.audioMed.type),
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
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
