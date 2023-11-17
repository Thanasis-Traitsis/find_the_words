bool checkSameRow({
  required int theRow,
  required int colsAndRows,
  bool isMinus = true,
}) {
  return theRow ~/ colsAndRows ==
      (isMinus ? theRow - 1 : theRow + 1) ~/ colsAndRows;
}

bool checkAvailableCol({
  required int col,
  required int colsAndRows,
}) {
  return col >= 0 && col < (colsAndRows * colsAndRows);
}
