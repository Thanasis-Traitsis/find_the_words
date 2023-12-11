// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/constants/constants.dart';
import '../../../../core/usecases/calculate_size.dart';
import '../../../../core/widgets/card_with_outline.dart';
import 'card_text.dart';
import 'words_alert_dialog.dart';

class BlueHomeCard extends StatelessWidget {
  bool isPorttrait;

  BlueHomeCard({
    Key? key,
    this.isPorttrait = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    void openDialogFunction(List<String> words) {
      showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          words.sort((a, b) {
            return a[0].compareTo(b[0]);
          });

          return WordsAlertDialog(
            context: context,
            words: words.length.toString(),
            wordsList: words,
          );
        },
      );
    }

    void prepareForExtraWordsList() async {
      final SharedPreferences prefs = await SharedPreferences.getInstance();

      // Try reading data from the 'items' key. If it doesn't exist, returns null.
      List<String>? words = prefs.getStringList(allWords);

      words ??= [];
      openDialogFunction(words);
    }

    return isPorttrait
        ? Expanded(
            child: Material(
              color: Colors.transparent,
              child: GestureDetector(
                onTap: () {
                  prepareForExtraWordsList();
                },
                child: CardWithOutline(
                  context: context,
                  color: Theme.of(context).cardColor,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CardText(
                        context: context,
                        text: 'Συνολικές Λέξεις',
                        color: Theme.of(context).colorScheme.outline,
                      ),
                      Text(
                        '',
                        style: TextStyle(
                          fontSize: calculateSize(
                            context,
                            Theme.of(context)
                                .textTheme
                                .headlineLarge!
                                .fontSize!,
                          ),
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.outline,
                        ),
                      ),
                      Expanded(
                        child: Container(
                          alignment: Alignment.centerRight,
                          child: Opacity(
                            opacity: .5,
                            child: Image.asset(
                              'assets/images/rafiki.png',
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )
        : SizedBox(
            width: double.infinity,
            child: Material(
              color: Colors.transparent,
              child: GestureDetector(
                onTap: () {
                  prepareForExtraWordsList();
                },
                child: CardWithOutline(
                  context: context,
                  color: Theme.of(context).cardColor,
                  child: Row(
                    children: [
                      ConstrainedBox(
                        constraints: BoxConstraints(minWidth: 100),
                        child: CardText(
                          context: context,
                          text: 'Συνολικές Λέξεις',
                          color: Theme.of(context).colorScheme.outline,
                        ),
                      ),
                      Expanded(
                        child: Text(
                          '',
                          style: TextStyle(
                            fontSize: calculateSize(
                              context,
                              Theme.of(context)
                                  .textTheme
                                  .headlineLarge!
                                  .fontSize!,
                            ),
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.outline,
                          ),
                          textAlign: TextAlign.right,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
  }
}
