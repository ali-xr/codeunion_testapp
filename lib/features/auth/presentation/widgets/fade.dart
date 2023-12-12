import 'package:flutter/material.dart';

PageRouteBuilder fade({required Widget page, RouteSettings? settings}) => PageRouteBuilder(
    transitionDuration: const Duration(milliseconds: 200),
    transitionsBuilder: (context, animation, secondaryAnimation, child) => FadeTransition(
      opacity: CurvedAnimation(
        curve: const Interval(0, 1, curve: Curves.linear),
        parent: animation,
      ),
      child: child,
    ),
    settings: settings,
    pageBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) => page);