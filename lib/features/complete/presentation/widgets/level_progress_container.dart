import 'package:find_the_words/features/complete/presentation/widgets/level_progress_indicator.dart';
import 'package:flutter/material.dart';

import '../../../../core/constants/sizes.dart';
import '../../../../core/constants/styles.dart';
import '../../../../core/usecases/calculate_size.dart';
import '../../../../core/widgets/card_with_outline.dart';
import 'complete_header.dart';

Widget LevelProgressContainer({
  required BuildContext context,
  required int level,
  required double progress,
  required int stage,
}) {
  return Column(
    children: [
      CompleteHeader(
        context: context,
        stage: stage,
      ),
      SizedBox(
        width: double.infinity,
        child: CardWithOutline(
          context: context,
          color: Theme.of(context).canvasColor,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Πρόοδος Επιπέδου',
                style: TextStyle(
                  fontSize: calculateSize(
                    context,
                    Theme.of(context).textTheme.bodyLarge!.fontSize!,
                  ),
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).textTheme.bodyLarge!.color,
                ),
              ),
              const SizedBox(
                height: gap / 4,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Επ. $level',
                    style: TextStyle(
                      fontSize: calculateSize(
                        context,
                        Theme.of(context).textTheme.bodyMedium!.fontSize!,
                      ),
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).textTheme.bodyMedium!.color,
                    ),
                  ),
                  Text(
                    'Επ. ${level + 1}',
                    style: TextStyle(
                      fontSize: calculateSize(
                        context,
                        Theme.of(context).textTheme.bodyMedium!.fontSize!,
                      ),
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).textTheme.bodyMedium!.color,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: gap / 4,
              ),
              LevelProgressIndicator(
                endValue: progress,
              ),
            ],
          ),
        ),
      )
    ],
  );
}
