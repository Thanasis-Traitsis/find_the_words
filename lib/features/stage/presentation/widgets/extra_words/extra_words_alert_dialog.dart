import 'package:flutter/material.dart';

import '../../../../../core/usecases/calculate_size.dart';
import 'extra_word.dart';

AlertDialog ExtraWordsAlertDialog({
  required BuildContext context,
  required List extra,
}) {
  return AlertDialog(
    title: Text(
      'Έξτρα Λέξεις',
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: calculateSize(
          context,
          Theme.of(context).textTheme.headlineLarge!.fontSize!,
        ),
      ),
    ),
    content: extra.isNotEmpty
        ? SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: calculateSize(
                  context,
                  200,
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: extra.asMap().entries.map<Widget>(
                  (e) {
                    return ExtraWord(
                      context: context,
                      text: e.value.toString(),
                    );
                  },
                ).toList(),
              ),
            ),
          )
        : Text(
            'Δεν έχετε βρει καμία έξτρα λέξη σε αυτό το στάδιο !',
            style: TextStyle(
              fontSize: calculateSize(
                context,
                Theme.of(context).textTheme.bodyLarge!.fontSize!,
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
