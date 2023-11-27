import 'package:find_the_words/core/constants/sizes.dart';
import 'package:flutter/material.dart';

import '../../../../core/constants/styles.dart';
import '../../../../core/usecases/calculate_size.dart';

Widget HomeButton({
  required BuildContext context,
  required Function function,
  required String stage,
}) {
  return Center(
    child: Stack(
      alignment: Alignment.center,
      children: [
        SizedBox(
          width: double.infinity,
          height: calculateSize(
            context,
            AppValuesMain().homeButtonSize,
          ),
        ),
        Positioned(
          bottom: calculateSize(context, 30),
          child: FilledButton(
            onPressed: () => function(),
            child: Text(
              'Επόμενο Στάδιο',
              style: TextStyle(
                fontSize: calculateSize(
                  context,
                  Theme.of(context).textTheme.bodyLarge!.fontSize!,
                ),
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          child: Container(
            padding: const EdgeInsets.symmetric(
              vertical: padding / 2,
              horizontal: padding * 2,
            ),
            decoration: BoxDecoration(
              border: Border.all(
                color: Theme.of(context).colorScheme.outline,
                width: 2,
              ),
              borderRadius: BorderRadius.circular(
                borderRadius,
              ),
              color: Theme.of(context).colorScheme.surface,
            ),
            child: Text(
              'Στάδιο $stage',
              style: TextStyle(
                fontSize: calculateSize(
                  context,
                  Theme.of(context).textTheme.bodyMedium!.fontSize!,
                ),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}
