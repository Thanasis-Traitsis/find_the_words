import 'package:find_the_words/core/constants/crossword_values.dart';

List moveTableToCenter({
  required int counterAboveMiddle,
  required int counterBelowMiddle,
  required int counterLeftMiddle,
  required int counterRightMiddle,
  required List<String> tblist,
  required List wordPositions,
}) {
  if (counterAboveMiddle - counterBelowMiddle > 0) {
    for (var r = 0; r < ((counterAboveMiddle - counterBelowMiddle) ~/ 2); r++) {
      for (var i = 0; i < tblist.length - tableRowsAndColumns; i++) {
        tblist[i] = tblist[i + tableRowsAndColumns];
      }
      for (var i = tblist.length - tableRowsAndColumns;
          i < tblist.length;
          i++) {
        tblist[i] = '';
      }

      for (var i = 0; i < wordPositions.length; i++) {
        for (var j = 0; j < wordPositions[i].length; j++) {
          wordPositions[i][j] = wordPositions[i][j] - tableRowsAndColumns;
        }
      }
    }
  }
  if (counterBelowMiddle - counterAboveMiddle > 1) {
    for (var r = 0; r < ((counterBelowMiddle - counterAboveMiddle) ~/ 2); r++) {
      for (var i = tblist.length - 1; i >= tableRowsAndColumns; i--) {
        tblist[i] = tblist[i - tableRowsAndColumns];
      }
      for (var i = 0; i < tableRowsAndColumns; i++) {
        tblist[i] = '';
      }

      for (var i = 0; i < wordPositions.length; i++) {
        for (var j = 0; j < wordPositions[i].length; j++) {
          wordPositions[i][j] = wordPositions[i][j] + tableRowsAndColumns;
        }
      }
    }
  }
  if (counterLeftMiddle - counterRightMiddle > 1) {
    for (var r = 0; r < ((counterLeftMiddle - counterRightMiddle) ~/ 2); r++) {
      for (var i = 0; i < tblist.length - 2; i++) {
        tblist[i] = tblist[i + 1];
      }

      tblist[tblist.length - 1] = '';

      for (var i = 0; i < wordPositions.length; i++) {
        for (var j = 0; j < wordPositions[i].length; j++) {
          wordPositions[i][j] = wordPositions[i][j] - 1;
        }
      }
    }
  }
  if (counterRightMiddle - counterLeftMiddle > 1) {
    for (var r = 0; r < ((counterRightMiddle - counterLeftMiddle) ~/ 2); r++) {
      for (var i = tblist.length - 2; i >= 0; i--) {
        tblist[i + 1] = tblist[i];
      }
      tblist[0] = '';

      for (var i = 0; i < wordPositions.length; i++) {
        for (var j = 0; j < wordPositions[i].length; j++) {
          wordPositions[i][j] = wordPositions[i][j] + 1;
        }
      }
    }
  }
  return [tblist, wordPositions];
}
