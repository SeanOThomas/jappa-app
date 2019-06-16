import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:jaap/data/dto/meditation.dart';

class MedListResults extends StatelessWidget {
  final List<Meditation> meditations;

  const MedListResults(this.meditations);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemBuilder: (context, index) => Card(
              child: InkWell(
                  child: Padding(
                    padding: const EdgeInsets.all(22.0),
                    child: Text(meditations[index].title),
                  ),
                  onTap: () {
                    print('${meditations[index].title} tapped');
                  }),
            ),
        itemCount: meditations.length,
      ),
    );
  }
}
