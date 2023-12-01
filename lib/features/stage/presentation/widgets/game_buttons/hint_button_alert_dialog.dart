import 'package:find_the_words/core/constants/styles.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../../core/constants/game_values.dart';
import '../../../../../core/usecases/calculate_size.dart';

AlertDialog HintButtonAlertDialog({
  required BuildContext context,
}) {
  return AlertDialog(
    title: Text(
      'Βοήθεια !',
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: calculateSize(
          context,
          Theme.of(context).textTheme.headlineLarge!.fontSize!,
        ),
      ),
    ),
    content: RichText(
      text: TextSpan(
        text: 'Θέλεις να ξοδέψεις',
        style: TextStyle(
          fontSize: calculateSize(
            context,
            Theme.of(context).textTheme.bodyLarge!.fontSize!,
          ),
          color: Theme.of(context).colorScheme.outline,
        ),
        children: [
          TextSpan(
            text: ' $hintCost πόντους',
            style: TextStyle(
              fontSize: calculateSize(
                context,
                Theme.of(context).textTheme.bodyLarge!.fontSize! + 2,
              ),
              color: Theme.of(context).colorScheme.outline,
              fontWeight: FontWeight.bold,
            ),
          ),
          TextSpan(
            text: ' για να ξεκλειδώσεις ένα νέο γράμμα στο σταυρόλεξο;',
            style: TextStyle(
              fontSize: calculateSize(
                context,
                Theme.of(context).textTheme.bodyLarge!.fontSize!,
              ),
              color: Theme.of(context).colorScheme.outline,
            ),
          )
        ],
      ),
    ),
    actions: <Widget>[
      HintAlertDialogButton(
        changeColor: true,
        context: context,
        widget: Text(
          'Όχι',
          style: TextStyle(
            fontSize: calculateSize(
              context,
              Theme.of(context).textTheme.bodyLarge!.fontSize!,
            ),
            fontWeight: FontWeight.bold,
          ),
        ),
        function: () {
          Navigator.pop(context, false);
        },
      ),
      HintAlertDialogButton(
        context: context,
        widget: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'ΝΑΙ',
              style: TextStyle(
                fontSize: calculateSize(
                  context,
                  Theme.of(context).textTheme.bodyLarge!.fontSize!,
                ),
                // color: Theme.of(context).colorScheme.outline,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              width: gap / 2,
            ),
            Row(
              children: [
                Text(
                  '- $hintCost',
                  style: TextStyle(
                    fontSize: calculateSize(
                      context,
                      Theme.of(context).textTheme.bodyMedium!.fontSize! + 2,
                    ),
                    color: Theme.of(context).colorScheme.outline,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  width: gap / 4,
                ), // Add spacing between Text and Icon widgets
                Icon(
                  FontAwesomeIcons.solidStar,
                  size: calculateSize(
                    context,
                    Theme.of(context).iconTheme.size! - 10,
                  ),
                  color: Theme.of(context).colorScheme.outline,
                ),
              ],
            ),
          ],
        ),
        function: () {
          Navigator.pop(context, true);
        },
      ),
    ],
  );
}

Widget HintAlertDialogButton({
  required BuildContext context,
  required Function function,
  required Widget widget,
  bool changeColor = false,
}) {
  return FilledButton(
    style: TextButton.styleFrom(
      backgroundColor:
          changeColor ? Theme.of(context).colorScheme.primary : null,
      textStyle: Theme.of(context).textTheme.labelLarge,
      padding: const EdgeInsets.symmetric(
          horizontal: padding * 1.5, vertical: padding / 2),
    ),
    child: widget,
    onPressed: () {
      function();
    },
  );
}
