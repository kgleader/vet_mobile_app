import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

// Helpers for creating widgets with BlocProvider in tests
class MockNavigatorObserver extends Mock implements NavigatorObserver {}

class FakeRoute extends Fake implements Route<dynamic> {}

extension PumpApp on WidgetTester {
  Future<void> pumpApp(
    Widget widget, {
    NavigatorObserver? navigator,
  }) async {
    await pumpWidget(
      MaterialApp(
        navigatorObservers: [
          if (navigator != null) navigator,
        ],
        home: widget,
      ),
    );
  }
}
