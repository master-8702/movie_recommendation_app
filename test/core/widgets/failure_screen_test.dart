import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:movie_recommendation_app/core/widgets/failure_screen.dart';

void main() {
  // here we are testing if there failure screen shows the given message.
  testWidgets(
      'Given message When rendering failure screen Then displays that message',
      (widgetTester) async {
    const message = 'no';
    await widgetTester.pumpWidget(const MaterialApp(
      home: FailureScreen(message: message),
    ));

    // here we are expecting one widget that will have the passed message 'no'.
    expect(find.text(message), findsOneWidget);
  });
}
