import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:movie_recommendation_app/core/widgets/primary_button.dart';
import 'package:movie_recommendation_app/features/movie_flow/movie_repository.dart';
import 'package:movie_recommendation_app/main.dart';

import 'stubs/stub_movie_repository.dart';

void main() {
  // just to make sure we have initialized the binding, which is required for the integration test
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  // here we are testing the general flow of the app like choosing something and clicking next (continue) until the end
  testWidgets('test basic flow and see the fake generated movie in the end',
      (widgetTester) async {
    await widgetTester.pumpWidget(
      ProviderScope(
        overrides: [
          movieRepositoryProvider.overrideWithValue(StubMovieRepository())
        ],
        child: const MyApp(),
      ),
    );

    // here we will click the first 'get started' button
    await widgetTester.tap(find.byType(PrimaryButton));

    // here we will wait( make sure our animations are done before we move to the next step using pumpAndSettle method
    // then we will find and click the 'Animation' genre button
    await widgetTester.pumpAndSettle();
    await widgetTester.tap(find.text('Animation'));
    // to navigate to the next page
    await widgetTester.tap(find.byType(PrimaryButton));

    // here will just wait and click continue (we will take the default rating value)
    await widgetTester.pumpAndSettle();
    await widgetTester.tap(find.byType(PrimaryButton));

    // here we will just wait and click the button again (by taking the default '3' years back value)
    await widgetTester.pumpAndSettle();
    await widgetTester.tap(find.byType(PrimaryButton));

    // and finally here we will find the movie - hobbs and shaw .. so we will just wait here
    await widgetTester.pumpAndSettle();
    // here we will check if the recommended movie is displayed on the screen. In our case the movie will just come from the stubMovieRepository
    // with title of 'Hobbs and Shaw'.
    // and the movie title (the actual parameter of the expect method) is coming from the stubMovieRepository
    expect(find.text('Hobbs and Shaw'), findsOneWidget);
  });

  testWidgets(
      'test basic flow but make sure we do not get past the genre screen unless we choose at least a single genre',
      (widgetTester) async {
    await widgetTester.pumpWidget(
      ProviderScope(
        overrides: [
          movieRepositoryProvider.overrideWithValue(StubMovieRepository())
        ],
        child: const MyApp(),
      ),
    );

    await widgetTester.tap(find.byType(PrimaryButton));
    await widgetTester.pumpAndSettle();
    // we will tap continue without selecting genre
    await widgetTester.tap(find.byType(PrimaryButton));

    // here even though we tap on the continue button without selecting any genre, there should be one widget with 'Animation' text
    // because we are still on the genre page (in short we did not get past).
    expect(find.text('Animation'), findsOneWidget);
  });
}
