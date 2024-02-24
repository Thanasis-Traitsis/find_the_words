import 'package:flutter/material.dart';

import '../../../../core/constants/game_values.dart';
import '../../../../core/constants/styles.dart';
import '../../../../core/widgets/card_with_outline.dart';
import 'card_text.dart';

Widget EarnPointsCard({
  required BuildContext context,
}) {
  return GestureDetector(
    onTap: () {},
    child: SizedBox(
      width: double.infinity,
      child: CardWithOutline(
        context: context,
        color: Theme.of(context).colorScheme.primary,
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(
                child: CardText(
                  context: context,
                  text: 'Κέρδισε $earnPoints πόντους',
                  color: Theme.of(context).colorScheme.background,
                ),
              ),
              const SizedBox(
                width: gap,
              ),
              Image.asset(
                'assets/images/video.png',
                width: 25,
              )
            ],
          ),
        ),
      ),
    ),
  );
}
