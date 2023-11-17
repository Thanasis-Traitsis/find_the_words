
import 'add_x_for_neighbors.dart';
import 'check_rows_columns.dart';

void placeNeighbors({
  required List positions,
  required List<String> tbList,
  required int colsAndRows,
  bool isHosizontal = true,
}) {
  if (isHosizontal) {
    for (var i = 0; i < positions.length; i++) {
      if (i == 0 &&
          checkSameRow(
            theRow: positions[i],
            colsAndRows: colsAndRows,
          ) &&
          checkAvailableCol(
            col: positions[i] - 1,
            colsAndRows: colsAndRows,
          )) {
        tbList[(positions[i] - 1)] = 'XX';
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
        tbList[(positions[i] + 1)] = 'XX';
      }

      checkAvailableCol(
        col: positions[i] + colsAndRows,
        colsAndRows: colsAndRows,
      )
          ? tbList[(positions[i] + colsAndRows)] = addXForNeighbor(tbList[(positions[i] + colsAndRows)])
          : null;

      checkAvailableCol(
        col: positions[i] - colsAndRows,
        colsAndRows: colsAndRows,
      )
          ? tbList[(positions[i] - colsAndRows)] = addXForNeighbor(tbList[(positions[i] - colsAndRows)])
          : null;
    }
  } else {
    for (var i = 0; i < positions.length; i++) {
      if (i == 0 &&
          checkAvailableCol(
            col: positions[i] - colsAndRows,
            colsAndRows: colsAndRows,
          )) {
        tbList[(positions[i] - colsAndRows)] = 'XX';
      } else if (i == positions.length - 1 &&
          checkAvailableCol(
            col: positions[i] + colsAndRows,
            colsAndRows: colsAndRows,
          )) {
        tbList[(positions[i] + colsAndRows)] = 'XX';
      }

      tbList[(positions[i] + 1)] = addXForNeighbor(tbList[(positions[i] + 1)]);
      tbList[(positions[i] - 1)] = addXForNeighbor(tbList[(positions[i] - 1)]);
    }
  }
}
