import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movie_recommendation_app/core/failure.dart';
import 'package:movie_recommendation_app/features/movie_flow/genre/genre.dart';
import 'package:movie_recommendation_app/features/movie_flow/genre/genre_entity.dart';
import 'package:movie_recommendation_app/features/movie_flow/movie_repository.dart';
import 'package:movie_recommendation_app/features/movie_flow/movie_service.dart';
import 'package:movie_recommendation_app/features/movie_flow/result/movie.dart';
import 'package:movie_recommendation_app/features/movie_flow/result/movie_entity.dart';

class MockMovieRepository extends Mock implements MovieRepository {}

void main() {
  late MovieRepository mockedMovieRepository;

  setUp(() {
    mockedMovieRepository = MockMovieRepository();
  });

  /// testing for the movies service on normal condition
  test(
      'Given successful call when getting GenreEntities Then map to correct Genres',
      () async {
    when(() => mockedMovieRepository.getMovieGenres())
        .thenAnswer((invocation) => Future.value([
              const GenreEntity(id: 0, name: 'Animation'),
            ]));
    final movieService =
        TMDBMovieService(movieRepository: mockedMovieRepository);

    final result = await movieService.getGenres();
    expect(result.tryGetSuccess(), [const Genre(name: 'Animation')]);
  });

  /// testing for the movies service when there is no connection
  test('Given failed call when getting GenreEntities Then return failure',
      () async {
    when(() => mockedMovieRepository.getMovieGenres()).thenThrow(
      Failure(
          message: 'No internet connection',
          exception: const SocketException('')),
    );

    final movieService =
        TMDBMovieService(movieRepository: mockedMovieRepository);

    final result = await movieService.getGenres();
    expect(result.tryGetError()?.exception, isA<SocketException>());
  });

  /// testing for the movies service when

  test(
      'Given successful call when getting MovieEntity Then map to correct Movie',
      () async {
    const genre = Genre(name: 'Animation', id: 1, isSelected: true);
    const movieEntity = MovieEntity(
        title: 'Hobbs and Shaw',
        overview: 'nice story between rock and jason',
        voteAverage: 7.5,
        genreIds: [1],
        releaseDate: '2019-06-18');

    when(() => mockedMovieRepository.getRecommendedMovies(any(), any(), any()))
        .thenAnswer((invocation) {
      return Future.value([
        movieEntity,
      ]);
    });

    final movieService =
        TMDBMovieService(movieRepository: mockedMovieRepository);
    final result =
        await movieService.getRecommendedMovie(5, 20, [genre], DateTime(2021));
    final movie = result.tryGetSuccess();

    expect(
        movie,
        Movie(
            title: movieEntity.title,
            overview: movieEntity.overview,
            voteAverage: movieEntity.voteAverage,
            genres: const [genre],
            releaseDate: movieEntity.releaseDate));
  });

  test('Given failed call When getting MovieEntities Then return failure',
      () async {
    const genre = Genre(name: 'Animation', id: 1, isSelected: true);
    when(() {
      mockedMovieRepository.getRecommendedMovies(any(), any(), any());
    }).thenThrow(
        Failure(message: 'message', exception: const SocketException('')));
    final movieService =
        TMDBMovieService(movieRepository: mockedMovieRepository);
    final result =
        await movieService.getRecommendedMovie(5, 20, [genre], DateTime(2021));

    expect(result.tryGetError()?.exception, isA<SocketException>());
  });
}
