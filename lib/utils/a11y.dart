import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';

class A11yUtils {
  static Widget announcePageChange(String pageName, Widget child) {
    return Semantics(
      liveRegion: true,
      child: Semantics(
        label: 'Navigated to $pageName',
        child: child,
      ),
    );
  }
  
  static Widget skipLink({
    required String target,
    required String label,
    required Widget child,
  }) {
    return Column(
      children: [
        Offstage(
          offstage: true,
          child: ElevatedButton(
            onPressed: () {
              // In a real implementation, this would scroll to the target
            },
            child: Text('Skip to $label'),
          ),
        ),
        Expanded(child: child),
      ],
    );
  }
}
