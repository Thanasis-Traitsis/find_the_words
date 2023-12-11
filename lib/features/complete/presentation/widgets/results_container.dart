import 'package:find_the_words/features/complete/presentation/widgets/total_points_container.dart';
import 'package:flutter/material.dart';
import '../../../../core/constants/constants.dart';
import 'text_with_result.dart';

Widget ResultsContainer({
  required BuildContext context,
  required Map stage,
}) {
  return Column(
    children: [
      TextWithResult(
        context: context,
        header: 'Συνολικές Λέξεις',
        stat: stage[completeStageWordsUsedInStage],
      ),
      TextWithResult(
        context: context,
        header: 'Συνολικές Έξτρα Λέξεις',
        stat: stage[completeStageExtraWordsFound],
      ),
      TextWithResult(
        context: context,
        header: 'Ολοκλήρωση Σταδίου',
        stat: stage[completeStageStageCompletion],
      ),
      stage[completeStageLevelUp]
          ? TextWithResult(
              context: context,
              header: 'Ολοκλήρωση Επιπέδου',
              stat: stage[completeStageLevelUpPoints],
            )
          : Container(),
      const Divider(
        thickness: 1,
      ),
      TotalPoints(
        context: context,
        sum: stage[completeStageSumOfPoints],
      ),
    ],
  );
}
