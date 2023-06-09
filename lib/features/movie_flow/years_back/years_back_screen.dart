import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_recommendation_app/features/movie_flow/movie_flow_controller.dart';
import 'package:movie_recommendation_app/features/movie_flow/result/result_screen.dart';

import '../../../core/constants.dart';
import '../../../core/widgets/primary_button.dart';

class YearsBackScreen extends ConsumerWidget {
  const YearsBackScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
            onPressed:
                ref.read(movieFlowControllerProvider.notifier).previousPage),
      ),
      body: Center(
        child: Column(
          children: [
            Text(
              "How many years back  should we check for?",
              style: theme.textTheme.headlineMedium,
              textAlign: TextAlign.center,
            ),
            const Spacer(),
            Column(
              children: [
                Text(
                  '${ref.watch(movieFlowControllerProvider).yearsBack}',
                  style: theme.textTheme.headlineLarge,
                ),
                Text(
                  "Years back",
                  style: theme.textTheme.headlineMedium?.copyWith(
                      color: theme.textTheme.headlineMedium?.color
                          ?.withOpacity(0.62)),
                ),
              ],
            ),
            const Spacer(),
            Slider(
                value:
                    ref.watch(movieFlowControllerProvider).yearsBack.toDouble(),
                min: 0,
                max: 70,
                // here we add division is to add the snapping behaviour
                divisions: 70,
                label:
                    '${ref.watch(movieFlowControllerProvider).yearsBack} years',
                onChanged: (value) {
                  ref
                      .read(movieFlowControllerProvider.notifier)
                      .updateYearsBack(value.toInt());
                }),
            const Spacer(),
            PrimaryButton(
                onPressed: () async {
                  Navigator.of(context).push(ResultScreen.route());

                  await ref
                      .read(movieFlowControllerProvider.notifier)
                      .getRecommendedMovie();
                },
                isLoading: ref.watch(movieFlowControllerProvider).movie
                    is AsyncLoading,
                text: 'Amazing'),
            const SizedBox(
              height: kMediumSpacing,
            )
          ],
        ),
      ),
    );
  }
}
