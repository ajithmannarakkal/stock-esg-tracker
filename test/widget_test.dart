import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:stock_esg_tracker/main.dart';

void main() {
  testWidgets('Dashboard screen smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(
      const ProviderScope(child: MyApp()),
    );

    // check that the app bar shows the correct title
    expect(find.text('Stock ESG Tracker'), findsOneWidget);

    // check empty state message
    expect(find.text('No stocks in portfolio'), findsOneWidget);

    // check the FAB is present
    expect(find.byIcon(Icons.add), findsOneWidget);
  });
}
