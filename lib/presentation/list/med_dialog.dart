import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:jaap/data/dto/meditation.dart';
import 'package:jaap/domain/models/med_list_model.dart';
import 'package:jaap/presentation/detail/med_detail_page.dart';
import 'package:provider/provider.dart';

import '../styles.dart';

class MedDialog extends StatelessWidget {
  final Meditation med;

  const MedDialog(this.med);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(BORDER_RADIUS_DEFAULT)),
      child: Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(BORDER_RADIUS_DEFAULT)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              height: 56,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(BORDER_RADIUS_DEFAULT), topRight: Radius.circular(BORDER_RADIUS_DEFAULT)),
                shape: BoxShape.rectangle,
                color: getTypeColor(med.type),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: PADDING_DEFAULT),
                child: Center(
                  child: Text(
                    med.title,
                    style: Theme.of(context).textTheme.subtitle,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(PADDING_DEFAULT),
              child: Text(
                med.description, textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(PADDING_DEFAULT),
              child: FlatButton(
                color: orangeOpaque,
                child: Padding(
                  padding: const EdgeInsets.all(14.0),
                  child: Text(
                    "PLAY",
                    style: Theme.of(context).textTheme.button,
                  ),
                ),
                shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
                onPressed: () {
                  Navigator.pop(context); // dismiss the dialog
                  Provider.of<MedListModel>(context).audioMed = med;
                  Navigator.pushNamed(context, MedDetailPage.ROUTE_NAME);
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
