import 'package:flutter/material.dart';
import 'package:jaap/domain/models/med_list_model.dart';
import 'package:provider/provider.dart';

import '../styles.dart';

class MedDetailPlay extends StatelessWidget {
  final bool isPlaying;

  const MedDetailPlay([this.isPlaying = true]);

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
                    value: true,
                    onChanged: (value) {},
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Text("Reminders"),
                Switch(
                  value: true,
                  onChanged: (value) {},
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
                          color: orange,
                        ),
                        flex: 1,
                      ),
                    ],
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: FloatingActionButton(
                      child: Icon(isPlaying ? Icons.pause : Icons.play_arrow),
                      onPressed: () {
                        isPlaying ? model.onPause() : model.onResume();
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
