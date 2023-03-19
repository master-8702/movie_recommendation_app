import 'package:flutter/material.dart';
import 'package:movie_recommendation_app/features/movie_flow/genre/genre.dart';
import 'package:movie_recommendation_app/features/movie_flow/result/movie.dart';

/// this will be our state class

const movieMock = Movie(
  title: 'The Hulk',
  overview:
      'Bruce Banner, a genetics researcher with a tragic past, suffers an accident that causes him...',
  genres: [Genre(name: 'Action'), Genre(name: 'Fantasy')],
  voteAverage: 4.8,
  releaseDate: '2019-05-24',
  backDropPath: '',
  posterPath: '',
);

const List<Genre> genresMock = [
  Genre(name: 'Action'),
  Genre(name: 'Comedy'),
  Genre(name: 'Horror'),
  Genre(name: 'Anime'),
  Genre(name: 'Drama'),
  Genre(name: 'Family'),
  Genre(name: 'Romance'),
];

/// here we are creating an immutable class, which values can not be changed
@immutable
class MovieFlowState {
  final PageController pageController;
  final int rating;
  final int yearsBack;
  final Movie movie;
  final List<Genre> genres;

  const MovieFlowState({
    required this.pageController,
    this.rating = 7,
    this.yearsBack = 3,
    this.movie = movieMock,
    this.genres = genresMock,
  });

  MovieFlowState copyWith(
      {PageController? pageController,
      int? rating,
      int? yearsBack,
      List<Genre>? genres,
      Movie? movie}) {
    return MovieFlowState(
        pageController: pageController ?? this.pageController,
        rating: rating ?? this.rating,
        yearsBack: yearsBack ?? this.yearsBack,
        movie: movie ?? this.movie,
        genres: genres ?? this.genres);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is MovieFlowState &&
        other.pageController == pageController &&
        other.rating == rating &&
        other.yearsBack == yearsBack &&
        other.movie == movie &&
        other.genres == genres;
  }

  @override
  // TODO: implement hashCode
  int get hashCode =>
      pageController.hashCode ^
      rating.hashCode ^
      yearsBack.hashCode ^
      movie.hashCode ^
      genres.hashCode;
}
