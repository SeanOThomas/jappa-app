import 'package:flutter/material.dart';
import 'package:jaap/presentation/detail/med_detail_page.dart';
import 'package:jaap/presentation/list/med_list_page.dart';
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
            primarySwatch: Colors.blue,
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
