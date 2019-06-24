import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:jaap/data/dto/meditation.dart';

import 'med_dialog.dart';

const LIST_PADDING = 28.0;

class MedListResults extends StatelessWidget {
  final List<Meditation> meditations;

  const MedListResults(this.meditations);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        padding: const EdgeInsets.all(LIST_PADDING),
        itemBuilder: (context, index) => Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: LIST_PADDING),
                ),
                Container(
                  height: 112.0,
                  decoration: BoxDecoration(
                    gradient: new LinearGradient(
                      colors: [
                        index.isOdd ? Colors.orange : Colors.cyan,
                        index.isOdd ? Colors.orangeAccent : Colors.cyanAccent
                      ],
                    ),
                    borderRadius: BorderRadius.circular(8.0),
                    shape: BoxShape.rectangle,
                    boxShadow: [
                      new BoxShadow(
                        color: Colors.grey,
                        offset: new Offset(5.0, 5.0),
                        blurRadius: 10.0,
                      )
                    ],
                  ),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () {
                        showDialog(context: context, builder: (BuildContext context) => MedDialog(meditations[index]));
                      },
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(left: LIST_PADDING, right: LIST_PADDING),
                          child: Text(
                            meditations[index].title,
                            style: Theme.of(context).textTheme.subtitle,
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
        itemCount: meditations.length,
      ),
    );
  }

  bool isOddIndex(int index) {
    return index.isOdd;
  }
}
