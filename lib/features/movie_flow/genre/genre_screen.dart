import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_recommendation_app/core/failure.dart';
import 'package:movie_recommendation_app/core/widgets/failure_screen.dart';
import 'package:movie_recommendation_app/features/movie_flow/genre/list_card.dart';
import 'package:movie_recommendation_app/features/movie_flow/movie_flow_controller.dart';

import '../../../core/constants.dart';
import '../../../core/widgets/primary_button.dart';

class GenreScreen extends ConsumerWidget {
  const GenreScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
            onPressed:
                ref.read(movieFlowControllerProvider.notifier).previousPage),
      ),
      body: Column(
        children: [
          Text(
            "Let's start with a genre",
            style: Theme.of(context).textTheme.headlineMedium,
            textAlign: TextAlign.center,
          ),
          Expanded(
            child: ref.watch(movieFlowControllerProvider).genres.when(
                  data: (genres) {
                    return ListView.separated(
                      padding: const EdgeInsets.symmetric(
                          vertical: kListItemSpacing),
                      itemCount: genres.length,
                      itemBuilder: (context, index) {
                        final genre = genres[index];
                        return ListCard(
                            genre: genre,
                            onTap: () => ref
                                .read(movieFlowControllerProvider.notifier)
                                .toggleSelected(genre));
                      },
                      separatorBuilder: (context, index) {
                        return const SizedBox(
                          height: kListItemSpacing,
                        );
                      },
                    );
                  },
                  error: (e, s) {
                    if (e is Failure) {
                      return FailureBody(message: e.message);
                    }
                    return const FailureBody(
                        message: 'Sorry,\nSomething went wrong on our end!');
                  },
                  loading: () => const Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
          ),
          PrimaryButton(
            onPressed: ref.watch(movieFlowControllerProvider.notifier).nextPage,
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
