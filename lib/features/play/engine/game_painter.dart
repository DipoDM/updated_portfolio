// game_painter.dart
import 'package:flutter/material.dart';
import 'game_loop.dart';

class GamePainter extends CustomPainter {
  final GameLoop loop;

  // ✅ The critical line: pass the loop as the repaint Listenable
  GamePainter(this.loop) : super(repaint: loop);

  @override
  void paint(Canvas canvas, Size size) {
    // draw using loop.playerX, loop.obstacles, loop.score, etc.
    // ...
  }

  // We don't swap painter instances, so no diffing needed.
  @override
  bool shouldRepaint(covariant GamePainter oldDelegate) => false;

  @override
  bool shouldRebuildSemantics(covariant GamePainter oldDelegate) => false;
}
