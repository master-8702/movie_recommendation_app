

// this class is a layer between the controller and the repository

import 'dart:math';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_recommendation_app/features/movie_flow/genre/genre.dart';
import 'package:movie_recommendation_app/features/movie_flow/movie_repository.dart';
import 'package:movie_recommendation_app/features/movie_flow/result/movie.dart';

final movieServiceProvider = Provider<MovieService>((ref) {
  final movieRepository = ref.watch(movieRepositoryProvider);
  return TMDBMovieService(movieRepository:  movieRepository);
}
);
abstract class MovieService{
  Future<List<Genre>> getGenres();
  Future<Movie> getRecommendedMovie(int rating, int yearsBack,  List<Genre> genres, [DateTime? yearsBackFromDate]);
}

class TMDBMovieService implements MovieService{
  final MovieRepository movieRepository;
  TMDBMovieService({ required this.movieRepository});

  @override
  Future<List<Genre>> getGenres() async{
   final genreEntities = await movieRepository.getMovieGenres();
   final genres = genreEntities.map((e) => Genre.fromEntity(e)  ).toList();
   return genres;

  }

  @override
  Future<Movie> getRecommendedMovie(int rating, int yearsBack, List<Genre> genres, [DateTime? yearsBackFromDate]) async{

    final date = yearsBackFromDate ?? DateTime.now();
    final year = date.year -yearsBack;
    final genreIds = genres.map((e) => e.id).toList().join(','); // adding genre ids by making them list and joining them using a coma as a separator

    final movieEntities = await movieRepository.getRecommendedMovies(rating.toDouble(), '$year-01-01', genreIds);
    final movies = movieEntities.map((e) => Movie.fromEntity(e, genres)).toList();
    // since we have a list and we need to just return a single random movie that meets the requirements we need to use random function

    final randomNumber = Random();
    final randomMovie =  movies[randomNumber.nextInt(movies.length)];
    return randomMovie;
  }


}