import 'package:movie_recommendation_app/features/movie_flow/genre/genre_entity.dart';
import 'package:movie_recommendation_app/features/movie_flow/movie_repository.dart';
import 'package:movie_recommendation_app/features/movie_flow/result/movie_entity.dart';

class StubMovieRepository implements MovieRepository {
  @override
  Future<List<GenreEntity>> getMovieGenres() {
    return Future.value([const GenreEntity(id: 1, name: 'Animation')]);
  }

  @override
  Future<List<MovieEntity>> getRecommendedMovies(
      double rating, String date, String genreIds) {
    return Future.value([
      const MovieEntity(
          title: 'Hobbs and Shaw',
          overview: 'Nice story between rock and jason',
          voteAverage: 7.5,
          genreIds: [1, 4, 8],
          releaseDate: '2021-01-23')
    ]);
  }
}
