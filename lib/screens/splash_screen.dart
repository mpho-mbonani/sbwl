import 'dart:math';

import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          margin: EdgeInsets.only(bottom: 20.0),
          padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 94.0),
          transform: Matrix4.rotationZ(0 * pi / 180)..translate(0.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                blurRadius: 8,
                color: Colors.black26,
                offset: Offset(0, 2),
              )
            ],
          ),
          child: Text(
            'SBWL',
            style: TextStyle(
              color: Theme.of(context).accentTextTheme.headline6.color,
              fontSize: 50,
              fontFamily: 'Anton',
              fontWeight: FontWeight.normal,
            ),
          ),
        ),
      ),
    );
  }
}
