import 'package:flutter/material.dart';

import '../../../../core/constants/styles.dart';
import '../../../../core/usecases/calculate_size.dart';

Widget AnswerContainer({
  required BuildContext context,
  required String answer,
}) {
  return Container(
    padding: answer.isNotEmpty
        ? EdgeInsets.only(
            right: calculateSize(
              context,
              3,
            ),
            bottom: calculateSize(
              context,
              3,
            ),
          )
        : null,
    decoration: answer.isNotEmpty
        ? BoxDecoration(
            color: Theme.of(context).colorScheme.outline,
            borderRadius: BorderRadius.circular(
              borderRadius,
            ),
          )
        : null,
    child: Container(
      padding: answer.isNotEmpty
          ? EdgeInsets.all(
              calculateSize(
                context,
                padding,
              ),
            )
          : null,
      decoration: answer.isNotEmpty
          ? BoxDecoration(
              color: Theme.of(context).colorScheme.primaryContainer,
              border: Border.all(
                color: Theme.of(context).colorScheme.outline,
                width: calculateSize(
                  context,
                  2,
                ),
              ),
              borderRadius: BorderRadius.circular(
                borderRadius,
              ),
            )
          : null,
      child: Text(
        answer.toUpperCase(),
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: calculateSize(
            context,
            Theme.of(context).textTheme.bodyLarge!.fontSize!,
          ),
          color: Theme.of(context).colorScheme.outline,
        ),
      ),
    ),
  );
}
