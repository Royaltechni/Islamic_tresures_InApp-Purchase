import 'package:flutter/material.dart';

class FadeInRoute extends PageRouteBuilder {
  final Widget page;

  FadeInRoute({this.page, String routeName, dynamic argument})
      : super(
          settings: RouteSettings(
              name: routeName, arguments: argument), // set name here
          pageBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) =>
              page,
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) =>
              FadeTransition(
            opacity: animation,
            child: child,
          ),
          transitionDuration: Duration(milliseconds: 200),
        );
}
