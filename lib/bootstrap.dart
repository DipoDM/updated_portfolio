import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'main.dart';

void bootstrap() {
  if (kIsWeb) {
    usePathUrlStrategy();
  }
  
  runApp(
    const ProviderScope(
      child: PortfolioApp(),
    ),
  );
}
