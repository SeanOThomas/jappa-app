import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:jaap/data/dto/meditation.dart';

class MedDialog extends StatelessWidget {
  final Meditation med;

  const MedDialog(this.med);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      child: Container(
        height: 350.0,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(20.0)),
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(14.0),
              child: Text(
                med.title,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
                padding: EdgeInsets.all(14.0),
                child: Text(
                  med.description,
                  style: TextStyle(
                    fontSize: 18,
                  ),
                )),
            Expanded(
                child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 14),
                      child: RaisedButton(
                        child: Text("Play"),
                        onPressed: () {
                          print("play pressed");
                        },
                      ),
                    )))
          ],
        ),
      ),
    );
  }
}
