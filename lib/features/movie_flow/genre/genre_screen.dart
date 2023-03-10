import 'package:flutter/material.dart';
import 'package:movie_recommendation_app/features/movie_flow/genre/genre.dart';
import 'package:movie_recommendation_app/features/movie_flow/genre/genre.dart';
import 'package:movie_recommendation_app/features/movie_flow/genre/list_card.dart';

import '../../../core/constants.dart';
import '../../../core/widgets/primary_button.dart';
import 'genre.dart';

class GenreScreen extends StatefulWidget {
  const GenreScreen(
      {Key? key, required this.nextPage, required this.previousPage})
      : super(key: key);

  final VoidCallback nextPage;

  final VoidCallback previousPage;

  @override
  State<GenreScreen> createState() => _GenreScreenState();
}

class _GenreScreenState extends State<GenreScreen> {
  List<Genre> genres = [
    const Genre(name: 'Action'),
    const Genre(name: 'Comedy'),
    const Genre(name: 'Horror'),
    const Genre(name: 'Anime'),
    const Genre(name: 'Drama'),
    const Genre(name: 'Family'),
    const Genre(name: 'Romance'),
  ];

  void toggleSelected(Genre genre) {
    List<Genre> updatedGenre = [
      for (final oldGenre in genres)
        if (oldGenre == genre) oldGenre.toggleSelected() else oldGenre
    ];

    setState(() {
      genres = updatedGenre;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(onPressed: widget.previousPage),
      ),
      body: Column(
        children: [
          Text(
            "Let's start with a genre",
            style: Theme.of(context).textTheme.headlineMedium,
            textAlign: TextAlign.center,
          ),
          Expanded(
              child: ListView.separated(
            padding: EdgeInsets.symmetric(vertical: kListItemSpacing),
            itemCount: genres.length,
            itemBuilder: (context, index) {
              final genre = genres[index];
              return ListCard(genre: genre, onTap: () => toggleSelected(genre));
            },
            separatorBuilder: (context, index) {
              return const SizedBox(
                height: kListItemSpacing,
              );
            },
          )),
          PrimaryButton(
            onPressed: widget.nextPage,
            text: 'Continue',
          ),
          const SizedBox(
            height: kMediumSpacing,
          )
        ],
      ),
    );
  }
}
