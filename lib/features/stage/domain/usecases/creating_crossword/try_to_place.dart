import 'package:flutter/material.dart';

import 'apply_changes.dart';
import 'check_direction.dart';
import 'new_word_positions_and_neighbors.dart';
import 'place_neighbors.dart';

bool tryToPlace({
  required List previousWordPosition,
  required int commonPositionNew,
  required int commonPosition,
  required String newWord,
  required int numRowsAndColumns,
  required List<String> tbList,
  required List<Widget> wdtList,
  required List wordsPositionList,
}) {
  // DES TA VIMATA KSANA ENA ENA KIA PRINTARE TA APOTELESMATA GIA NA DEIS SE TI FASI EISAI
  // check the direction of the previous word
  bool previousIsHorizontal = false;
  previousIsHorizontal = checkDirection(previousWordPosition);

  // check and place neighbors
  List? positions = newWordPositionsAndNeighbors(
    previousWordPosition: previousWordPosition,
    commonPositionNew: commonPositionNew,
    commonPosition: commonPosition,
    newWord: newWord,
    numRowsAndColumns: numRowsAndColumns,
    tbList: tbList,
    previousIsHorizontal: previousIsHorizontal,
  );

  if (positions != null) {
    List list = List.from(positions);
    list.removeAt(commonPositionNew);

    placeNeighbors(
      positions: list,
      tbList: tbList,
      colsAndRows: numRowsAndColumns,
      isHosizontal: !previousIsHorizontal,
    );

    for (var i = 0; i < positions.length; i++) {
      tbList[positions[i]] = newWord[i];
    }

    wordsPositionList.add(positions);

    return true;
  }

  return false;
}
