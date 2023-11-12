import 'dart:math';

int positionWordCenterHorizontaly({
  required int tableLength,
  required String word,
}) {
  int center = ((sqrt(tableLength).ceil() ~/ 2) * sqrt(tableLength).ceil()) +
      (sqrt(tableLength).ceil() ~/ 2);

  int startPosition = tableLength % 2 != 0 ? center - 1 : center - 2;

  if (word.length > 3) {
    startPosition = startPosition - (word.length ~/ 3);
  }

  return startPosition;
}
