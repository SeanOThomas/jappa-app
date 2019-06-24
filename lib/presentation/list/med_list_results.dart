import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:jaap/data/dto/meditation.dart';

import '../styles.dart';
import 'med_dialog.dart';

class MedListResults extends StatelessWidget {
  final List<Meditation> meditations;

  const MedListResults(this.meditations);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Japp"),
        centerTitle: true,
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 12.0),
            child: IconButton(
              icon: Icon(Icons.settings),
              onPressed: () {},
            ),
          )
        ],
        elevation: 8.0,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(PADDING_DEFAULT),
        itemBuilder: (context, index) => Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: index == 0 ? 0 : PADDING_DEFAULT),
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
                    borderRadius: BorderRadius.circular(BORDER_RADIUS_DEFAULT),
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
                          padding: const EdgeInsets.symmetric(horizontal: PADDING_DEFAULT),
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
}
