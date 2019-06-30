import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:jappa/data/dto/meditation.dart';

import '../styles.dart';
import 'med_dialog.dart';

class MedListResults extends StatelessWidget {
  final List<Meditation> meditations;

  const MedListResults(this.meditations);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
          padding: const EdgeInsets.all(PADDING_DEFAULT),
          itemCount: meditations.length + 1,
          itemBuilder: (context, index) {
            if (index == 0) {
              return Padding(
                padding: const EdgeInsets.only(top: 12),
                child: Image.asset("assets/images/logo_jappa.png", fit: BoxFit.fitHeight, height: 84),
              );
            }
            index -= 1;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: index == 0 ? PADDING_DEFAULT : PADDING_DEFAULT),
                ),
                Container(
                  height: CARD_HEIGHT,
                  decoration: BoxDecoration(
                    color: getTypeColor(meditations[index].type),
                    borderRadius: BorderRadius.circular(BORDER_RADIUS_LARGE),
                    boxShadow: [new BoxShadow(color: Colors.grey, offset: new Offset(5.0, 5.0), blurRadius: 10.0)],
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
            );
          }),
    );
  }
}
