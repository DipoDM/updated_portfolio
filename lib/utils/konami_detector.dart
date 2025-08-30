import 'package:flutter/services.dart';

class KonamiDetector {
  static const _konamiCode = [
    LogicalKeyboardKey.arrowUp,
    LogicalKeyboardKey.arrowUp,
    LogicalKeyboardKey.arrowDown,
    LogicalKeyboardKey.arrowDown,
    LogicalKeyboardKey.arrowLeft,
    LogicalKeyboardKey.arrowRight,
    LogicalKeyboardKey.arrowLeft,
    LogicalKeyboardKey.arrowRight,
    LogicalKeyboardKey.keyB,
    LogicalKeyboardKey.keyA,
  ];
  
  final List<LogicalKeyboardKey> _inputSequence = [];
  final VoidCallback onKonamiCode;
  
  KonamiDetector({required this.onKonamiCode});
  
  void handleKeyEvent(RawKeyEvent event) {
    if (event is RawKeyDownEvent) {
      _inputSequence.add(event.logicalKey);
      
      // Keep only the last 10 keys
      if (_inputSequence.length > _konamiCode.length) {
        _inputSequence.removeAt(0);
      }
      
      // Check if sequence matches Konami code
      if (_inputSequence.length == _konamiCode.length) {
        bool matches = true;
        for (int i = 0; i < _konamiCode.length; i++) {
          if (_inputSequence[i] != _konamiCode[i]) {
            matches = false;
            break;
          }
        }
        
        if (matches) {
          onKonamiCode();
          _inputSequence.clear();
        }
      }
    }
  }
  
  void reset() {
    _inputSequence.clear();
  }
}
