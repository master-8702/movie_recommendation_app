import 'package:flutter/material.dart';
import 'package:movie_recommendation_app/features/movie_flow/result/movie.dart';

import '../genre/genre.dart';

import '../../../core/constants.dart';
import '../../../core/widgets/primary_button.dart';

class ResultScreen extends StatelessWidget {
  static route({bool fullscreenDialog = true}) => MaterialPageRoute(
        builder: (context) => const ResultScreen(),
      );
  const ResultScreen({Key? key}) : super(key: key);

  final double movieHeight = 150;
  final movie = const Movie(
    title: 'The Hulk',
    overview:
        'Bruce Banner, a genetics researcher with a tragic past, suffers an accident that causes him...',
    genres: [Genre(name: 'Action'), Genre(name: 'Fantasy')],
    voteAverage: 4.8,
    releaseDate: '2019-05-24',
    backDropPath: '',
    posterPath: '',
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              children: [
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    const CoverImage(),
                    Positioned(
                      width: MediaQuery.of(context).size.width,
                      bottom: -(movieHeight / 2),
                      child: MovieImageDetails(
                          movie: movie, movieHeight: movieHeight),
                    )
                  ],
                ),
                SizedBox(
                  height: movieHeight / 2,
                ),
                Padding(
                  padding: EdgeInsets.all(12),
                  child: Text(
                    movie.overview,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                )
              ],
            ),
          ),
          PrimaryButton(
              onPressed: () => Navigator.of(context).pop(),
              text: 'Find another movie')
        ],
      ),
    );
  }
}

class CoverImage extends StatelessWidget {
  const CoverImage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(minHeight: 300),
      child: ShaderMask(shaderCallback: (rect) {
        return LinearGradient(
            begin: Alignment.center,
            end: Alignment.bottomCenter,
            colors: [
              Theme.of(context).scaffoldBackgroundColor,
              Colors.transparent
            ]).createShader(Rect.fromLTRB(0, 0, rect.width, rect.height));
      }),
    );
  }
}

class MovieImageDetails extends StatelessWidget {
  const MovieImageDetails(
      {Key? key, required this.movie, required this.movieHeight})
      : super(key: key);

  final Movie movie;
  final double movieHeight;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        children: [
          SizedBox(
            width: 100,
            height: movieHeight,
            child: Placeholder(),
          ),
          const SizedBox(
            height: kMediumSpacing,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  movie.title,
                  style: theme.textTheme.titleLarge,
                ),
                Text(
                  movie.genresCommaSeparated,
                  style: theme.textTheme.bodyMedium,
                ),
                Row(
                  children: [
                    Text(
                      movie.voteAverage.toString(),
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.textTheme.bodyMedium?.color
                            ?.withOpacity(0.62),
                      ),
                    ),
                    const Icon(
                      Icons.star_rounded,
                      size: 20,
                      color: Colors.amber,
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
