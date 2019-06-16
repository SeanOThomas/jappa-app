import 'package:flutter/material.dart';
import 'package:jaap/presentation/detail/med_detail_page.dart';
import 'package:jaap/presentation/list/med_list_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: MedListPage.ROUTE_NAME,
      routes: {
        MedListPage.ROUTE_NAME: (_) => MedListPage(),
        MedDetailPage.ROUTE_NAME: (_) => MedDetailPage()
      },
    );
  }
}
