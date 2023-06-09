import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_recommendation_app/features/movie_flow/genre/genre.dart';
import 'package:movie_recommendation_app/features/movie_flow/result/movie.dart';

/// this will be our state class


/// here we are creating an immutable class, which values can not be changed
@immutable
class MovieFlowState {
  final PageController pageController;
  final int rating;
  final int yearsBack;
  final AsyncValue<Movie> movie;
  final AsyncValue<List<Genre>> genres;

  const MovieFlowState({
    required this.pageController,
    this.rating = 7,
    this.yearsBack = 3,
    required this.movie,
    required this.genres,
  });

  MovieFlowState copyWith(
      {PageController? pageController,
      int? rating,
      int? yearsBack,
      AsyncValue<List<Genre>>? genres,
      AsyncValue<Movie>? movie}) {
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
