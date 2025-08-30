// lib/core/widgets/responsive.dart
import 'package:flutter/material.dart';

class Responsive {
  // Modern, smoother breakpoints (you can keep yours if you prefer)
  static const double _bpCompact = 600; // phones
  static const double _bpMedium = 840; // large phones / small tablets
  static const double _bpExpanded = 1200; // tablets / small desktops
  static const double _bpLarge = 1600; // big desktops

  static double _w(BuildContext c) => MediaQuery.of(c).size.width;

  static bool isMobile(BuildContext c) => _w(c) < _bpCompact;
  static bool isTablet(BuildContext c) => _w(c) >= _bpCompact && _w(c) < _bpExpanded;
  static bool isDesktop(BuildContext c) => _w(c) >= _bpExpanded;
  static bool isLargeDesktop(BuildContext c) => _w(c) >= _bpLarge;

  /// Horizontal gutter that scales with width (≈4vw), clamped.
  /// This is the ONE value you should use for left/right padding.
  static double edgeGutter(BuildContext c) {
    final g = _w(c) * 0.04; // ~4% of viewport width
    return g.clamp(16.0, 40.0); // min 16, max 40
  }

  /// Fluid content rail width using a CSS-like clamp(min, preferred, max).
  /// Grows with the screen until capped for readability.
  static double contentMaxWidth(BuildContext c) {
    final w = _w(c);
    final preferred = w - 2 * edgeGutter(c); // ~92vw
    final double min = w < _bpMedium ? w : 840.0;
    const double max = 1280.0;
    return preferred.clamp(min, max);
  }

  /// Preferred rail padding (horizontal only). Use this in most places.
  static EdgeInsets railPadding(BuildContext c) => EdgeInsets.symmetric(horizontal: edgeGutter(c));

  /// Optional vertical rhythm helper for sections.
  static EdgeInsets sectionVPadding(BuildContext c) => EdgeInsets.symmetric(vertical: isDesktop(c) ? 32 : 24);

  // --------------------------------------------------------------------------
  // Backwards-compat shims (keep your old calls working)
  // --------------------------------------------------------------------------

  /// Old name -> now returns the fluid rail width.
  static double getMaxWidth(BuildContext c) => contentMaxWidth(c);

  /// Old API returned all-sides padding (16/24/32) which often caused “double gutters”.
  /// We default to **horizontal-only** now. Set includeVertical=true if you relied on the old behavior.
  static EdgeInsets getPadding(BuildContext c, {bool includeVertical = false}) {
    final h = edgeGutter(c);
    final v = includeVertical
        ? (isDesktop(c)
            ? 32.0
            : isTablet(c)
                ? 24.0
                : 16.0)
        : 0.0;
    return EdgeInsets.symmetric(horizontal: h, vertical: v);
  }
}
