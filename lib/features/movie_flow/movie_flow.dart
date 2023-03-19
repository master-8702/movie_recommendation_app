import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_recommendation_app/features/movie_flow/genre/genre_screen.dart';
import 'package:movie_recommendation_app/features/movie_flow/landing/landing_screen.dart';
import 'package:movie_recommendation_app/features/movie_flow/rating/rating_screen.dart';
import 'package:movie_recommendation_app/features/movie_flow/years_back/years_back_screen.dart';
import 'package:movie_recommendation_app/features/movie_flow/movie_flow_controller.dart';

// consumer widget is very similar with stateless widget,  it will make it possible
// to get the notifier that we get from the riverpod
class MovieFlow extends ConsumerWidget {
  const MovieFlow({Key? key}) : super(key: key);

  //here the widgetRef is a widget which will let us get it from the providers
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PageView(
      controller: ref.watch(movieFlowControllerProvider).pageController,
      // disabling the scroll behavior of the pageview because we want the users to click a button rather that just scrolling
      physics: const NeverScrollableScrollPhysics(),
      children: const [
        LandingScreen(),
        GenreScreen(),
        RatingScreen(),
        YearsBackScreen()
      ],
    );
  }
}
