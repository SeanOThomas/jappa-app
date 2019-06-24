import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:jaap/data/dto/meditation.dart';
import 'package:jaap/domain/models/med_list_model.dart';
import 'package:jaap/presentation/detail/med_detail_page.dart';
import 'package:provider/provider.dart';

class MedDialog extends StatelessWidget {
  final Meditation med;

  const MedDialog(this.med);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      child: Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(20.0)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              height: 56,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(topLeft: Radius.circular(8.0), topRight: Radius.circular(8.0)),
                shape: BoxShape.rectangle,
                gradient: new LinearGradient(
                  colors: [Colors.orange, Colors.orangeAccent],
                ),
              ),
              child: Center(
                child: Text(
                  med.title,
                  style: Theme.of(context).textTheme.subtitle,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(28.0),
              child: Text(
                med.description,
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
            ),
            Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: EdgeInsets.only(bottom: 14),
                  child: RaisedButton(
                    child: Text("Play"),
                    onPressed: () {
                      Navigator.pop(context); // dismiss the dialog
                      Provider.of<MedListModel>(context).audioMed = med;
                      Navigator.pushNamed(context, MedDetailPage.ROUTE_NAME);
                    },
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
