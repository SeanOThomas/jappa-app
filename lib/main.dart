import 'package:flutter/material.dart';
import 'package:jaap/presentation/detail/med_detail_page.dart';
import 'package:jaap/presentation/list/med_list_page.dart';
import 'package:jaap/presentation/styles.dart';
import 'package:provider/provider.dart';

import 'domain/models/med_list_model.dart';
import 'domain/state/med_list_state.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider<MedListModel>.value(value: _provideListModel(Loading()))],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(
            primaryColor: primaryGreen,
            accentColor: Colors.blueGrey,
            textTheme: TextTheme(
                subtitle: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold, color: Colors.white, letterSpacing: 1),
                button: TextStyle(
                    fontSize: 14.0, fontWeight: FontWeight.normal, color: Colors.deepOrange, letterSpacing: 2),
                body1: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.normal,
                    color: Colors.blueGrey,
                    letterSpacing: 1,
                    height: 1.5),
                display1:
                    TextStyle(fontSize: 28.0, fontWeight: FontWeight.bold, color: Colors.blueGrey, letterSpacing: 1)),
          ),
          initialRoute: MedListPage.ROUTE_NAME,
          routes: {MedListPage.ROUTE_NAME: (_) => MedListPage(), MedDetailPage.ROUTE_NAME: (_) => MedDetailPage()}),
    );
  }

  MedListModel _provideListModel(MedListState initState) {
    final model = MedListModel(initState);
    model.init();
    return model;
  }
}
