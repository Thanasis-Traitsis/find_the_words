import 'package:find_the_words/core/constants/styles.dart';
import 'package:find_the_words/core/widgets/card_with_outline.dart';
import 'package:flutter/material.dart';

import '../../../../core/usecases/calculate_size.dart';

AlertDialog WordsAlertDialog({
  required BuildContext context,
  required String words,
  required List wordsList,
}) {
  return AlertDialog(
    elevation: 0,
    title: Text(
      'Συνολικές Λέξεις $words',
      style: const TextStyle(
        fontWeight: FontWeight.bold,
      ),
    ),
    backgroundColor: Theme.of(context).cardColor,
    content: wordsList.isNotEmpty
        ? SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: wordsList
                  .map(
                    (item) => Container(
                      margin: const EdgeInsets.only(bottom: gap / 2),
                      child: CardWithOutline(
                        context: context,
                        color: Theme.of(context).colorScheme.primary,
                        child: Text(
                          item.toString().toUpperCase(),
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.surface,
                            fontSize: calculateSize(
                              context,
                              Theme.of(context).textTheme.bodyMedium!.fontSize!,
                            ),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
          )
        : Text(
            'Η λίστα με τις συνολικές λέξεις που έχεις βρει είναι κενή.',
            style: TextStyle(
              fontSize: calculateSize(
                context,
                Theme.of(context).textTheme.bodyMedium!.fontSize!,
              ),
            ),
          ),
    actions: <Widget>[
      TextButton(
        style: TextButton.styleFrom(
          textStyle: Theme.of(context).textTheme.labelLarge,
        ),
        child: Text(
          'Κλείσιμο',
          style: TextStyle(
            color: Theme.of(context).colorScheme.primary,
            fontSize: calculateSize(
              context,
              Theme.of(context).textTheme.bodyMedium!.fontSize!,
            ),
            fontWeight: FontWeight.bold,
          ),
        ),
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
    ],
  );
}
