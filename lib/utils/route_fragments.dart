import 'dart:html' as html;
import 'package:flutter/foundation.dart';

class RouteFragments {
  static void updateHash(String hash) {
    if (kIsWeb) {
      html.window.history.replaceState(null, '', '#$hash');
    }
  }
  
  static String getCurrentHash() {
    if (kIsWeb) {
      return html.window.location.hash.replaceFirst('#', '');
    }
    return '';
  }
  
  static void scrollToSection(String sectionId) {
    if (kIsWeb) {
      final element = html.document.getElementById(sectionId);
      element?.scrollIntoView();
    }
  }
}
