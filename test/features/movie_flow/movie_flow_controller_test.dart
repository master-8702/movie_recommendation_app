import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movie_recommendation_app/features/movie_flow/genre/genre.dart';
import 'package:movie_recommendation_app/features/movie_flow/movie_flow_controller.dart';
import 'package:movie_recommendation_app/features/movie_flow/movie_service.dart';
import 'package:multiple_result/multiple_result.dart';

class MockMovieService extends Mock implements MovieService {}

void main() {
  late MovieService mockedMovieService;
  late ProviderContainer container;
  late Genre genre;

  setUp(() {
    mockedMovieService = MockMovieService();
    container = ProviderContainer(overrides: [
      movieServiceProvider.overrideWithValue(mockedMovieService)
    ]);
    genre = const Genre(name: 'Animation');
    when(() => mockedMovieService.getGenres()).thenAnswer(
      (invocation) => Future.value(
        Success([
          genre,
        ]),
      ),
    );
  });

  // to dispose the provider container after we finish the test
  tearDown(() => container.dispose());

  // to group our tests
  group('MovieFlowControllerTests :', () {
    test('Given genre When Toggle Then that genre should be toggled', () async {
      await container
          .read(movieFlowControllerProvider.notifier)
          .stream
          .firstWhere((state) => state.genres is AsyncData);

      container
          .read(movieFlowControllerProvider.notifier)
          .toggleSelected(genre);

      final toggledGenre = genre.toggleSelected();

      expect(container.read(movieFlowControllerProvider).genres.value,
          [toggledGenre]);
    });

    // parametrized test, which we can run for multiple values like to test the rating service
    for (final rating in [0, 7, 10, 2, -2]) {
      test(
          'Given different rating When updating rating with $rating Then that rating should be represented',
          () {
        container
            .read(movieFlowControllerProvider.notifier)
            .updateRating(rating);
        // here we add the condition inside the expect method,  because we are expecting 0 rather than the given number
        // when the given number is less than 0. for other cases we are expecting the given rating to be represented.
        expect(container.read(movieFlowControllerProvider).rating,
            rating < 0 ? 0 : rating);
      });
    }

    for (final yearsBack in [2, 5, 8, 20, -8, -3]) {
      test(
          'Given different yearsBack When updating yearsBack with $yearsBack Then that yearsBack should be represented',
          () {
        container
            .read(movieFlowControllerProvider.notifier)
            .updateYearsBack(yearsBack);

        expect(container.read(movieFlowControllerProvider).yearsBack,
            yearsBack < 0 ? 0 : yearsBack);
      });
    }
  });
}
