import 'package:flutter/material.dart';

import 'try_to_place.dart';

bool checkCommonLetter({
  required List previousWordPosition,
  required String previousWord,
  required String newWord,
  required int numRowsAndColumns,
  required List<String> tbList,
  required List<Widget> wdtList,
  required List wordsPositionList,
}) {
  for (var i = 0; i < previousWord.length; i++) {
    for (var j = 0; j < newWord.length; j++) {
      if (previousWord[i] == newWord[j]) {
        bool successfulPlacement = tryToPlace(
          previousWordPosition: previousWordPosition,
          commonPosition: i,
          commonPositionNew: j,
          newWord: newWord,
          numRowsAndColumns: numRowsAndColumns,
          tbList: tbList,
          wdtList: wdtList,
          wordsPositionList: wordsPositionList,
        );
        if (successfulPlacement) {
          return true;
        }
      }
    }
  }

  return false;
}
