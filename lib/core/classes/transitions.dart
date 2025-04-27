// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';

push(context, Widget widget) {
  return Navigator.push(
    context,
    SlideTransitionPageRoute_LeftToRight(page: widget),
  );
}

pushReplcement(context, Widget widget) {
  return Navigator.pushReplacement(
    context,
    SlideTransitionPageRoute_LeftToRight(page: widget),
  );
}

pushAndRemoveAll(context, Widget widget) {
  return Navigator.pushAndRemoveUntil(
    context,
    SlideTransitionPageRoute_LeftToRight(page: widget),
    (route) => false,
  );
}

pop(context, Widget widget) {
  return Navigator.pop(
    context,
    SlideTransitionPageRoute_LeftToRight(page: widget),
  );
}

// ما وظيفة هذا الكود
Route getRotue(Widget page) {
  return SlideTransitionPageRoute_LeftToRight(page: page);
}

// transition animation left to right scale

class SlideTransitionPageRoute_LeftToRight<T> extends PageRouteBuilder<T> {
  final Widget page;

  SlideTransitionPageRoute_LeftToRight({required this.page})
    : super(
        pageBuilder:
            (
              BuildContext context,
              Animation<double> animation,
              Animation<double> secondaryAnimation,
            ) => page,
        transitionsBuilder:
            (
              BuildContext context,
              Animation<double> animation,
              Animation<double> secondaryAnimation,
              Widget child,
            ) => SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(-1.0, 0.0),
                end: Offset.zero,
              ).animate(animation),
              child: child,
            ),
        transitionDuration: const Duration(milliseconds: 300),
      );
}

class SlideTransitionPageRoute_RightToLeft<T> extends PageRouteBuilder<T> {
  final Widget page;

  SlideTransitionPageRoute_RightToLeft({required this.page})
    : super(
        pageBuilder:
            (
              BuildContext context,
              Animation<double> animation,
              Animation<double> secondaryAnimation,
            ) => page,
        transitionsBuilder:
            (
              BuildContext context,
              Animation<double> animation,
              Animation<double> secondaryAnimation,
              Widget child,
            ) => SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(
                  1.0,
                  0.0,
                ), // تغيير القيمة هنا لتكون (1.0, 0.0)
                end: Offset.zero,
              ).animate(animation),
              child: child,
            ),
        transitionDuration: const Duration(milliseconds: 300),
      );
}

// Circle Trabsition Animation

//transition

Route createRoute(Widget screen) {
  return PageRouteBuilder(
    transitionDuration: const Duration(milliseconds: 1500),
    reverseTransitionDuration: const Duration(milliseconds: 1000),
    opaque: false,
    barrierDismissible: false,
    pageBuilder: (context, animation, secondaryAnimation) => screen,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      var screenSize = MediaQuery.of(context).size;
      Offset center = Offset(screenSize.width / 2, screenSize.height / 2);
      double beginRadius = 0;
      double endRadius = screenSize.height * 1.2;
      var tween = Tween(begin: beginRadius, end: endRadius);
      var radiusTweenAnimation = animation.drive(tween);
      return ClipPath(
        clipper: CircleRevealClipper(
          radius: radiusTweenAnimation,
          center: center,
        ),
        child: child,
      );
    },
  );
}

// circle reveal clipper
class CircleRevealClipper extends CustomClipper<Path> {
  final center;
  final Animation<double> radius; // Change the type to Animation<double>

  CircleRevealClipper({this.center, required this.radius});

  @override
  Path getClip(Size size) {
    final double radiusValue = radius.value; // Extract the double value
    return Path()
      ..addOval(Rect.fromCircle(radius: radiusValue, center: center));
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}
