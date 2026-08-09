import 'package:flutter/material.dart';

class PageTransition {
  static Route slide(Widget page) {
    return PageRouteBuilder(
      transitionDuration: const Duration(milliseconds: 350),

      pageBuilder: (_, animation, secondaryAnimation) {
        return page;
      },

      transitionsBuilder: (_, animation, secondaryAnimation, child) {
        const begin = Offset(1, 0);

        const end = Offset.zero;

        const curve = Curves.easeInOut;

        final tween = Tween(
          begin: begin,
          end: end,
        ).chain(CurveTween(curve: curve));

        return SlideTransition(position: animation.drive(tween), child: child);
      },
    );
  }

  static Route fade(Widget page) {
    return PageRouteBuilder(
      transitionDuration: const Duration(milliseconds: 300),

      pageBuilder: (_, animation, secondaryAnimation) {
        return page;
      },

      transitionsBuilder: (_, animation, secondaryAnimation, child) {
        return FadeTransition(opacity: animation, child: child);
      },
    );
  }

  static Route scale(Widget page) {
    return PageRouteBuilder(
      transitionDuration: const Duration(milliseconds: 350),

      pageBuilder: (_, animation, secondaryAnimation) {
        return page;
      },

      transitionsBuilder: (_, animation, secondaryAnimation, child) {
        return ScaleTransition(scale: animation, child: child);
      },
    );
  }
}
