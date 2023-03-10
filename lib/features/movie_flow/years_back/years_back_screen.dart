import 'package:flutter/material.dart';
import 'package:movie_recommendation_app/features/movie_flow/result/result_screen.dart';

import '../../../core/constants.dart';
import '../../../core/widgets/primary_button.dart';

class YearsBackScreen extends StatefulWidget {
  const YearsBackScreen(
      {Key? key, required this.nextPage, required this.previousPage})
      : super(key: key);

  final VoidCallback nextPage;
  final VoidCallback previousPage;

  @override
  State<YearsBackScreen> createState() => _YearsBackScreenState();
}

class _YearsBackScreenState extends State<YearsBackScreen> {
  double yearsBack = 10;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(onPressed: widget.previousPage),
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
                  '${yearsBack.ceil()}',
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
                value: yearsBack,
                min: 0,
                max: 70,
                // here we add division is to add the snapping behaviour
                divisions: 70,
                label: '${yearsBack.ceil()} years',
                onChanged: (value) {
                  setState(() {
                    yearsBack = value;
                  });
                }),
            const Spacer(),
            PrimaryButton(
                onPressed: () =>
                    Navigator.of(context).push(ResultScreen.route()),
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
