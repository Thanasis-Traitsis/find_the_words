import 'package:find_the_words/features/complete/domain/usecases/calculating_progress/progress_based_on_seconds_and_extra_words.dart';
import 'package:find_the_words/features/complete/domain/usecases/calculating_progress/progress_based_on_simfona.dart';
import 'package:find_the_words/features/complete/domain/usecases/calculating_progress/progress_based_on_smallest_word.dart';
import 'package:find_the_words/features/complete/domain/usecases/calculating_progress/progress_based_on_stage_words.dart';
import 'package:flutter/material.dart';

import 'progress_based_on_biggest_word.dart';
import 'progress_based_on_crossword_length.dart';
import 'progress_based_on_extra_words.dart';
import 'progress_based_on_letters.dart';

Future<double> calculatingTheProgress({
  required int secondsCount,
  required int stageWordsLength,
  required int biggestWordLength,
  required int smallestWordLength,
  required int crosswordLength,
  required int extraWordsLength,
  required BuildContext context,
  required String letters,
}) async {
  // calculating stage words
  // +
  double sum1 = progressBasedOnStageWords(stageWordsLength);

  // calculating the biggest word
  // +
  double sum2 = progressBasedOnBiggestWord(biggestWordLength);

  // calculating the smallest word
  // -
  double min1 = progressBasedOnSmallestWord(smallestWordLength);

  // calculating the crossword words
  // +
  double sum3 = progressBasedOnCrosswordLength(crosswordLength);

  // calculating the extra words
  // +
  double sum4 = progressBasedOnExtraWords(extraWordsLength);

  // calculating simfona of the stage letters
  // +
  double sum5 = await progressBasedOnSimfona(context, letters);

  // calculating the rarity of letters
  // +
  double sum6 = progressBasedOnLetters(letters);

  // calculating seconds for stage completion and extra words
  // -
  double sec = progressBasedOnSecondsAndExtraWords(
    seconds: secondsCount,
    extraWords: extraWordsLength,
    level: letters.length - 2,
  );

  var result = (sum1 + sum2 + sum3 + sum4 + sum5 + sum6 - min1) * sec;

  print(result);

  return result;
}
