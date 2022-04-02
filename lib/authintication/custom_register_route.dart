import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';

class CustomPageRoute extends PageRouteBuilder {
  final Widget child;
  final AxisDirection direction;
  CustomPageRoute({required this.child, this.direction = AxisDirection.right})
      : super(
            transitionDuration: Duration(milliseconds: 300),
            reverseTransitionDuration: Duration(milliseconds: 300),
            pageBuilder: (context, animation, secondaryAnimation) => child);
  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
          Animation<double> secondaryAnimation, Widget child) =>
      /* FadeTransition(
          opacity: animation, alwaysIncludeSemantics: true, child: child);*/
      SlideTransition(
        position: Tween<Offset>(begin: Offset(1, 0), end: Offset.zero)
            .animate(animation),
        child: child,
      );
}
