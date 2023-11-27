import 'dart:math';

import 'check_direction.dart';
import 'check_if_spots_available.dart';

List? newWordPositionsAndNeighbors({
  required List previousWordPosition,
  required int commonPositionNew,
  required int commonPosition,
  required String newWord,
  required int numRowsAndColumns,
  required List<String> tbList,
  required bool previousIsHorizontal,
}) {
  List positions = [];
  List<String> copyTbList = tbList;

  if (previousIsHorizontal) {
    for (var i = 0; i < commonPositionNew; i++) {
      positions.add(
          previousWordPosition[commonPosition] - (numRowsAndColumns * (i + 1)));
    }
    for (var i = 0; i < (newWord.length - commonPositionNew); i++) {
      positions
          .add(previousWordPosition[commonPosition] + (numRowsAndColumns * i));
    }

    positions.sort();

    if (checkIfSpotsAvailable(
      positions: positions,
      commonPositionNew: commonPositionNew,
      copyTbList: copyTbList,
      newWord: newWord,
      numRowsAndColumns: numRowsAndColumns,
    )) {
      return positions;
    }
  } else {
    for (var i = 0; i < commonPositionNew; i++) {
      positions.add(previousWordPosition[commonPosition] - (i + 1));
    }
    for (var i = 0; i < (newWord.length - commonPositionNew); i++) {
      positions.add(previousWordPosition[commonPosition] + i);
    }

    positions.sort();

    if (checkIfSpotsAvailable(
      positions: positions,
      commonPositionNew: commonPositionNew,
      copyTbList: copyTbList,
      newWord: newWord,
      numRowsAndColumns: numRowsAndColumns,
    )) {
      return positions;
    }
  }

  return null;
}
