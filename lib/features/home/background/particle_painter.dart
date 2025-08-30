/*// lib/features/home/background/particle_painter.dart
import 'dart:math' as math;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class ParticleBackground extends StatefulWidget {
  const ParticleBackground({super.key});

  @override
  State<ParticleBackground> createState() => _ParticleBackgroundState();
}

class _ParticleBackgroundState extends State<ParticleBackground> with SingleTickerProviderStateMixin, WidgetsBindingObserver {
  late final Ticker _ticker;
  double _t = 0.0;
  bool _respectReducedMotion = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    // No context reads here.
    _ticker = createTicker((elapsed) {
      if (!mounted || _respectReducedMotion) return;
      setState(() => _t = elapsed.inMilliseconds / 1000.0);
    })
      ..start();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Safe place to read MediaQuery/Theme.
    final mq = MediaQuery.maybeOf(context);
    _respectReducedMotion = mq?.disableAnimations ?? false;

    if (_respectReducedMotion && _ticker.isActive) _ticker.stop();
    if (!_respectReducedMotion && !_ticker.isActive) _ticker.start();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // Be polite on web/tab switches.
    if (state == AppLifecycleState.paused || state == AppLifecycleState.inactive) {
      _ticker.muted = true;
    } else if (state == AppLifecycleState.resumed) {
      _ticker.muted = false;
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _ticker.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Size comes from parent via LayoutBuilder; no MediaQuery needed.
    return LayoutBuilder(
      builder: (context, constraints) {
        final size = Size(
          constraints.maxWidth.isFinite ? constraints.maxWidth : 0,
          constraints.maxHeight.isFinite ? constraints.maxHeight : 0,
        );
        return CustomPaint(
          isComplex: true,
          willChange: true,
          size: size,
          painter: _ParticlePainter(time: _t),
        );
      },
    );
  }
}

class _ParticlePainter extends CustomPainter {
  _ParticlePainter({required this.time});

  final double time;
  final Paint _p = Paint()..isAntiAlias = true;

  @override
  void paint(Canvas canvas, Size size) {
    if (size.isEmpty) return;

    // Subtle gradient wash
    final bg = Rect.fromLTWH(0, 0, size.width, size.height);
    final g = LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        const Color(0xFF0B1020),
        const Color(0xFF18223D),
      ],
    );
    canvas.drawRect(bg, Paint()..shader = g.createShader(bg));

    // Sparse drifting dots
    final int count = (math.min(size.width, size.height) / 24).clamp(12, 60).toInt();
    for (var i = 0; i < count; i++) {
      final seed = i * 37.0;
      final dx = (size.width) * _hash01(seed + 1.23);
      final amp = 16.0 + 20.0 * _hash01(seed + 9.99);
      final speed = 0.2 + _hash01(seed + 4.56);
      final dy = (size.height) * _hash01(seed + 7.89) + math.sin(time * speed + seed) * amp;

      _p.color = Colors.white.withOpacity(0.08 + 0.12 * _hash01(seed + 2.34));
      canvas.drawCircle(Offset(dx, dy), 1.5 + 1.5 * _hash01(seed + 3.21), _p);
    }
  }

  double _hash01(double x) {
    // Simple deterministic hash -> [0,1)
    return (math.sin(x) * 43758.5453).abs() % 1.0;
  }

  @override
  bool shouldRepaint(_ParticlePainter old) => old.time != time;
}
*/

// lib/features/home/background/particle_painter.dart
import 'dart:math' as math;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class ParticleBackground extends StatefulWidget {
  const ParticleBackground({super.key});

  @override
  State<ParticleBackground> createState() => _ParticleBackgroundState();
}

class _ParticleBackgroundState extends State<ParticleBackground> with SingleTickerProviderStateMixin, WidgetsBindingObserver {
  late final Ticker _ticker;
  double _t = 0.0;
  bool _respectReducedMotion = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _ticker = createTicker((elapsed) {
      if (!mounted || _respectReducedMotion) return;
      setState(() => _t = elapsed.inMilliseconds / 1000.0);
    })
      ..start();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final mq = MediaQuery.maybeOf(context);
    _respectReducedMotion = mq?.disableAnimations ?? false;
    if (_respectReducedMotion && _ticker.isActive) _ticker.stop();
    if (!_respectReducedMotion && !_ticker.isActive) _ticker.start();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    _ticker.muted = state != AppLifecycleState.resumed;
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _ticker.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Theme-driven colors
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final bool dark = theme.brightness == Brightness.dark;

    // Blend primary/secondary into surfaces for a subtle, theme-aware wash
    final Color gradStart = Color.alphaBlend(
      scheme.primary.withOpacity(dark ? 0.10 : 0.08),
      scheme.surface,
    );
    final Color gradEnd = Color.alphaBlend(
      scheme.secondary.withOpacity(dark ? 0.16 : 0.12),
      scheme.surfaceVariant,
    );

    // Base particle color from onSurface (keeps contrast in both modes)
    final Color dotBase = scheme.onSurface;

    return LayoutBuilder(
      builder: (context, constraints) {
        final size = Size(
          constraints.maxWidth.isFinite ? constraints.maxWidth : 0,
          constraints.maxHeight.isFinite ? constraints.maxHeight : 0,
        );
        return CustomPaint(
          isComplex: true,
          willChange: true,
          size: size,
          painter: _ParticlePainter(
            time: _t,
            gradStart: gradStart,
            gradEnd: gradEnd,
            dotBase: dotBase,
          ),
        );
      },
    );
  }
}

class _ParticlePainter extends CustomPainter {
  _ParticlePainter({
    required this.time,
    required this.gradStart,
    required this.gradEnd,
    required this.dotBase,
  });

  final double time;
  final Color gradStart;
  final Color gradEnd;
  final Color dotBase;

  final Paint _p = Paint()..isAntiAlias = true;

  @override
  void paint(Canvas canvas, Size size) {
    if (size.isEmpty) return;

    // Theme-driven gradient background
    final rect = Offset.zero & size;
    final grad = LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [gradStart, gradEnd],
    );
    canvas.drawRect(rect, Paint()..shader = grad.createShader(rect));

    // Sparse drifting dots
    final int count = (math.min(size.width, size.height) / 24).clamp(12, 60).toInt();
    for (var i = 0; i < count; i++) {
      final seed = i * 37.0;
      final dx = size.width * _hash01(seed + 1.23);
      final amp = 16.0 + 20.0 * _hash01(seed + 9.99);
      final speed = 0.2 + _hash01(seed + 4.56);
      final dy = size.height * _hash01(seed + 7.89) + math.sin(time * speed + seed) * amp;

      _p.color = dotBase.withOpacity(0.05 + 0.10 * _hash01(seed + 2.34)); // theme-aware
      canvas.drawCircle(Offset(dx, dy), 1.5 + 1.5 * _hash01(seed + 3.21), _p);
    }
  }

  double _hash01(double x) => (math.sin(x) * 43758.5453).abs() % 1.0;

  @override
  bool shouldRepaint(covariant _ParticlePainter old) => old.time != time || old.gradStart != gradStart || old.gradEnd != gradEnd || old.dotBase != dotBase;
}
