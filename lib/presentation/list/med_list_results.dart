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
        padding:  const EdgeInsets.all(LIST_PADDING),
        itemBuilder: (context, index) =>
        Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: LIST_PADDING),
            ),
            Card(
              child: InkWell(
                  child: Padding(
                    padding: const EdgeInsets.all(LIST_PADDING),
                    child: Text(meditations[index].title,
                        style: Theme.of(context).textTheme.subtitle),
                  ),
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) =>
                            MedDialog(meditations[index]));
                  }),
            ),
          ],
        ),
        itemCount: meditations.length,
      ),
    );
  }
}
