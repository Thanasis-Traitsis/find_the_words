import 'package:find_the_words/core/usecases/calculate_size.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../../core/widgets/card_with_outline.dart';

Widget ExtraWord({
  required BuildContext context,
  required String text,
}) {
  return CardWithOutline(
    context: context,
    color: Theme.of(context).canvasColor,
    hasColor: true,
    child: SizedBox(
      width: double.infinity,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontSize: calculateSize(
                  context,
                  Theme.of(context).textTheme.bodyLarge!.fontSize!,
                ),
                fontWeight: FontWeight.bold,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Icon(
            FontAwesomeIcons.solidStar,
            color: Theme.of(context).colorScheme.outline,
            size: calculateSize(
              context,
              Theme.of(context).primaryIconTheme.size! - 15,
            ),
          ),
        ],
      ),
    ),
  );
}
