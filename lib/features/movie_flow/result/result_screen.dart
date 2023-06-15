import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_recommendation_app/core/failure.dart';
import 'package:movie_recommendation_app/core/widgets/failure_screen.dart';
import 'package:movie_recommendation_app/features/movie_flow/movie_flow_controller.dart';
import 'package:movie_recommendation_app/features/movie_flow/result/movie.dart';

import '../../../core/constants.dart';
import '../../../core/widgets/primary_button.dart';

class ResultScreen extends ConsumerWidget {
  static route({bool fullscreenDialog = true}) => MaterialPageRoute(
        builder: (context) => const ResultScreen(),
      );
  const ResultScreen({Key? key}) : super(key: key);

  final double movieHeight = 150;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(movieFlowControllerProvider).movie.when(
          data: (movie) {
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
                            CoverImage(movie: movie),
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
                          padding: const EdgeInsets.all(12),
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
          },
          error: (e, s) {
            if (e is Failure) {
              return FailureScreen(message: e.message);
            }
            return const FailureScreen(
                message: 'Sorry, \n Something went wrong on our end.');
          },
          loading: () => const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          ),
        );
  }
}

class CoverImage extends StatelessWidget {
  final Movie movie;
  const CoverImage({Key? key, required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(minHeight: 300),
      child: ShaderMask(
          shaderCallback: (rect) {
            return LinearGradient(
                begin: Alignment.center,
                end: Alignment.bottomCenter,
                colors: [
                  Theme.of(context).scaffoldBackgroundColor,
                  Colors.transparent
                ]).createShader(Rect.fromLTRB(0, 0, rect.width, rect.height));
          },
          blendMode: BlendMode.dstIn,
          child: Image.network(
            movie.backDropPath ?? '',
            fit: BoxFit.cover,
            errorBuilder: (context, e, s) {
              return const Placeholder();
            },
          )),
    );
  }
}

class MovieImageDetails extends ConsumerWidget {
  final Movie movie;
  final double movieHeight;

  const MovieImageDetails(
      {Key? key, required this.movie, required this.movieHeight})
      : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        children: [
          SizedBox(
            width: 100,
            height: movieHeight,
            child: Image.network(
              movie.posterPath ?? '',
              fit: BoxFit.cover,
              errorBuilder: (context, e, s) {
                return const Placeholder();
              },
            ),
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
