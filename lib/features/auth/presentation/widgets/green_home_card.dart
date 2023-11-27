import 'package:flutter/material.dart';

import '../../../../core/widgets/card_with_outline.dart';
import 'card_text.dart';

Widget GreenHomeCard({
  required BuildContext context,
  required String level,
}) {
  return SizedBox(
    width: double.infinity,
    child: CardWithOutline(
      context: context,
      color: Theme.of(context).canvasColor,
      child: Center(
        child: CardText(
          context: context,
          text: 'Επίπεδο $level',
          color: Theme.of(context).colorScheme.outline,
        ),
      ),
    ),
  );
}
