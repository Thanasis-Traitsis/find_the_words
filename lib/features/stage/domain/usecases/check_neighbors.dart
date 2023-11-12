import 'package:find_the_words/features/stage/domain/usecases/box_is_not_letter.dart';

import 'check_rows_columns.dart';

bool checkNeighbors({
  required List positions,
  required List<String> tbList,
  required int colsAndRows,
  required int commonPositionNew,
  bool isHosizontal = true,
}) {
  // FTANEI MEXRI AFTO TO SHMEIO, ALLA META KATI PAEI LATHOS

  if (isHosizontal) {
    for (var i = 0; i < positions.length; i++) {
      if (i != commonPositionNew) {
        if (i == 0 &&
            checkSameRow(
              theRow: positions[i],
              colsAndRows: colsAndRows,
            ) &&
            checkAvailableCol(
              col: positions[i] - 1,
              colsAndRows: colsAndRows,
            )) {
          if (boxIsNotLetter(tbList[(positions[i] - 1)])) {
            return false;
          }
        } else if (i == positions.length - 1 &&
            checkSameRow(
              theRow: positions[i],
              colsAndRows: colsAndRows,
              isMinus: false,
            ) &&
            checkAvailableCol(
              col: positions[i] + 1,
              colsAndRows: colsAndRows,
            )) {
          if (boxIsNotLetter(tbList[(positions[i] + 1)])) {
            return false;
          }
        }

        if (checkAvailableCol(
          col: positions[i] + colsAndRows,
          colsAndRows: colsAndRows,
        )) {
          if (boxIsNotLetter(tbList[(positions[i] + colsAndRows)])) {
            // if (positions[0] == 46) { 
            //   print(tbList[positions[i] + colsAndRows]);
            //   print('object');
            // }
            return false;
          }
        }

        if (checkAvailableCol(
          col: positions[i] - colsAndRows,
          colsAndRows: colsAndRows,
        )) {
          if (boxIsNotLetter(tbList[(positions[i] - colsAndRows)]))
            return false;
        }
      }
    }
  } else {
    for (var i = 0; i < positions.length; i++) {
      if (i != commonPositionNew) {
        if (i == 0 &&
            checkAvailableCol(
              col: positions[i] - colsAndRows,
              colsAndRows: colsAndRows,
            )) {
          // print((positions[i] - colsAndRows));

          if (boxIsNotLetter(tbList[(positions[i] - colsAndRows)]))
            return false;
        } else if (i == positions.length - 1 &&
            checkAvailableCol(
              col: positions[i] + colsAndRows,
              colsAndRows: colsAndRows,
            )) {
          // print((positions[i] + colsAndRows));

          if (boxIsNotLetter(tbList[(positions[i] + colsAndRows)]))
            return false;
        }

        // print((positions[i] - 1));
        // print((positions[i] + 1));

        if (boxIsNotLetter(tbList[(positions[i] + 1)])) {
          return false;
        }
        if (boxIsNotLetter(tbList[(positions[i] - 1)])) {
          return false;
        }
      }
    }
  }
  return true;
}
