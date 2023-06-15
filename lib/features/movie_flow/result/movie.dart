import 'package:flutter/foundation.dart';
import '../genre/genre.dart';
import 'package:movie_recommendation_app/features/movie_flow/result/movie_entity.dart';

@immutable
class Movie {
  final String title;
  final String overview;
  final num voteAverage;
  final List<Genre> genres;
  final String releaseDate;
  final String? backDropPath;
  final String? posterPath;

  const Movie({
    required this.title,
    required this.overview,
    required this.voteAverage,
    required this.genres,
    required this.releaseDate,
    this.backDropPath,
    this.posterPath,
  });

  Movie.initial()
      : title = '',
        overview = '',
        voteAverage = 0,
        genres = [],
        releaseDate = '',
        backDropPath = '',
        posterPath = '';

  factory Movie.fromEntity(MovieEntity movieEntity, List<Genre> genres) {
    return Movie(
        title: movieEntity.title,
        overview: movieEntity.overview,
        voteAverage: movieEntity.voteAverage,
        genres: genres
            .where((genre) => movieEntity.genreIds.contains(genre.id))
            .toList(growable: false),
        releaseDate: movieEntity.releaseDate,
        backDropPath:
            'https://image.tmdb.org/t/p/original/${movieEntity.backdropPath}',
        posterPath:
            'https://image.tmdb.org/t/p/original/${movieEntity.posterPath}');
  }

  String get genresCommaSeparated =>
      genres.map((e) => e.name).toList().join(', ');

  @override
  String toString() {
    return 'Movie(title: $title, overview: $overview, voteAverage: $voteAverage, genres: $genres, releasedDate: $releaseDate)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Movie &&
        other.title == title &&
        other.overview == overview &&
        other.voteAverage == voteAverage &&
        listEquals(other.genres, genres) &&
        other.releaseDate == releaseDate;
  }

  @override
  int get hashCode {
    return title.hashCode ^
        overview.hashCode ^
        voteAverage.hashCode ^
        genres.hashCode ^
        releaseDate.hashCode;
  }
}
