import 'package:flutter/material.dart';
import 'package:visibility_detector/visibility_detector.dart';

class ScrollSection extends StatelessWidget {
  final String sectionId;
  final Widget child;
  final VoidCallback? onVisible;
  
  const ScrollSection({
    super.key,
    required this.sectionId,
    required this.child,
    this.onVisible,
  });

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: Key(sectionId),
      onVisibilityChanged: (info) {
        if (info.visibleFraction > 0.5 && onVisible != null) {
          onVisible!();
        }
      },
      child: child,
    );
  }
}
