import 'package:flutter/material.dart';
import 'package:jaap/domain/models/med_list_model.dart';
import 'package:provider/provider.dart';

class MedDetailPlay extends StatelessWidget {

  final String filePath;

  const MedDetailPlay(this.filePath);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        Provider.of<MedListModel>(context).onCleanMed();
        Navigator.pop(context);
      },
      child: Scaffold(
        body: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Text("Vrindavan sounds"),
                Switch(
                  value: true,
                  onChanged:(value) {
                  },
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Text("Reminders"),
                Switch(
                  value: true,
                  onChanged:(value) {
                  },
                ),
              ],
            ),
            Text("last played: $filePath")
          ],
        ),
      ),
    );
  }

}