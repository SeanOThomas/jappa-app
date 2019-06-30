import 'package:flutter/material.dart';

class SplashPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(color: Colors.white),
        child: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset("assets/images/logo_jappa_alt.png", fit: BoxFit.fitHeight, height: 200),
            Image.asset("assets/images/logo_jappa_subtitle.png", fit: BoxFit.fitHeight, height: 100),
          ],
        )));
  }
}
