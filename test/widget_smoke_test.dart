import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:portfolio/main.dart';

void main() {
  testWidgets('Portfolio app smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(
      const ProviderScope(
        child: PortfolioApp(),
      ),
    );

    expect(find.text('Oladipo Danmusa'), findsOneWidget);
    expect(find.text('Technical Lead and Senior Mobile Developer'), findsOneWidget);
  });
}
