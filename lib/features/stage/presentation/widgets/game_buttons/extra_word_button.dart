import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../../core/constants/sizes.dart';
import '../../../../../core/usecases/calculate_size.dart';
import 'game_button.dart';

Widget ExtraWordButton({
  required BuildContext context,
  required double endOfAnimation,
  required VoidCallback onEnd,
}) {
  return Stack(
    alignment: Alignment.center,
    children: [
      SizedBox(
        height: 100,
        width: calculateSize(context, AppValuesMain().gameButton),
      ),
      AnimatedPositioned(
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
        bottom: endOfAnimation,
        onEnd: onEnd,
        child: Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Theme.of(context).colorScheme.outline,
          ),
          width: calculateSize(
            context,
            AppValuesMain().gameButton * .7,
          ),
          height: calculateSize(
            context,
            AppValuesMain().gameButton * .7,
          ),
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Theme.of(context).colorScheme.primaryContainer,
              border: Border.all(
                color: Theme.of(context).colorScheme.outline,
                width: 1,
              ),
            ),
            margin: EdgeInsets.only(
              bottom: calculateSize(
                context,
                2,
              ),
              right: calculateSize(
                context,
                2,
              ),
            ),
            child: Icon(
              FontAwesomeIcons.plus,
              color: Theme.of(context).colorScheme.background,
              size: calculateSize(
                context,
                Theme.of(context).primaryIconTheme.size! * .6,
              ),
            ),
          ),
        ),
      ),
      Positioned(
        bottom: 0,
        child: GameButton(
          context: context,
          icon: FontAwesomeIcons.boxOpen,
          function: () {},
          isBox: true,
        ),
      ),
    ],
  );
}
