import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:movie_recommendation_app/core/widgets/primary_button.dart';

// here we are testing if the primary button shows the progress indicator (loading) sign when isLoading is True.
void main() {
  testWidgets(
      'Given primary button When loading is true Then find progress indicator.',
      (widgetTester) async {
    await widgetTester.pumpWidget(
      MaterialApp(
        home: PrimaryButton(
          onPressed: () {},
          text: '',
          isLoading: true,
        ),
      ),
    );

    final loadingIndicationFinder = find.byType(CircularProgressIndicator);
    expect(loadingIndicationFinder, findsOneWidget);
  });

  // here we are testing if the button is not showing the loading button when isLoading is False (the opposite of the above test).
  testWidgets(
    'Given primary button When isLoading is false Then finds no progress indicator',
    (widgetTester) async {
      await widgetTester.pumpWidget(
        MaterialApp(
          home: PrimaryButton(
            onPressed: () {},
            text: 'test',
            isLoading: false,
          ),
        ),
      );

      final loadingIndicationFInder = find.byType(CircularProgressIndicator);
      expect(loadingIndicationFInder, findsNothing);
      expect(find.text('test'), findsOneWidget);
    },
  );

  // here we are testing if the button is showing the given text on the button.
  testWidgets(
    'Given text When creating primary button Then displays the text',
    (widgetTester) async {
      await widgetTester.pumpWidget(
        MaterialApp(
          home: PrimaryButton(
            onPressed: () {},
            text: 'test',
            isLoading: false,
          ),
        ),
      );

      expect(find.text('test'), findsOneWidget);
    },
  );
}
