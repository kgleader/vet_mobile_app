// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:vet_mobile_app/main.dart';

void main() {
  testWidgets('App initializes properly', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const VetMobileApp());

    // Verify that the app initializes without errors
    expect(find.byType(MaterialApp), findsOneWidget);
    
    // Basic smoke test - ensure no exceptions during initialization
    expect(tester.takeException(), isNull);
  });
}
