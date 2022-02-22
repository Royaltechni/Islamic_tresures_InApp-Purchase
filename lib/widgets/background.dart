import 'dart:ui';

import 'package:flutter/material.dart';

class Background extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        Container(
          decoration: new BoxDecoration(
            image: new DecorationImage(
              image: new ExactAssetImage('assets/images/weather.jpeg'),
              fit: BoxFit.cover,
            ),
          ),
          child: new BackdropFilter(
            filter: new ImageFilter.blur(sigmaX: 0.0, sigmaY: 0.0),
            child: new Container(
              decoration: new BoxDecoration(
                  color: Color.fromRGBO(17, 180, 228, 1).withOpacity(0.0)),
            ),
          ),
        ),
      ],
    ));
  }
}
