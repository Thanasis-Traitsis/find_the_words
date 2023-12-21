import 'package:find_the_words/features/stage/domain/usecases/game_usecases/extra_words_repositories.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../core/constants/constants.dart';
import '../../../../../core/constants/sizes.dart';
import '../../../../../core/usecases/calculate_size.dart';
import '../extra_words/extra_words_alert_dialog.dart';
import 'game_button.dart';

Widget ExtraWordButton({
  required BuildContext context,
  required double endOfAnimation,
  required VoidCallback onEnd,
  bool isLandScape = false,
}) {
  return Stack(
    alignment: Alignment.center,
    children: [
      SizedBox(
        height: 150,
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
            isLandScape
                ? AppValuesMain().gameButton * .6
                : AppValuesMain().gameButton * .7,
          ),
          height: calculateSize(
            context,
            isLandScape
                ? AppValuesMain().gameButton * .6
                : AppValuesMain().gameButton * .7,
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
                isLandScape
                    ? Theme.of(context).primaryIconTheme.size! * .5
                    : Theme.of(context).primaryIconTheme.size! * .6,
              ),
            ),
          ),
        ),
      ),
      Positioned(
        bottom: 0,
        child: GameButton(
          isLandScape: isLandScape,
          context: context,
          icon: FontAwesomeIcons.boxOpen,
          function: () async {
            List extraWords = await getExtraWordsRepository();

            // ignore: use_build_context_synchronously
            showDialog<void>(
              context: context,
              builder: (BuildContext context) {
                return ExtraWordsAlertDialog(
                  context: context,
                  extra: extraWords,
                );
              },
            );
          },
          isBox: true,
        ),
      ),
    ],
  );
}
