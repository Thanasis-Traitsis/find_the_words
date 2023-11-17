int checkIfTableCanBeSmaller({
  required List tableDirections,
  required int tableRowsAndColumns,
}) {
  // PRWTA THA PROSPATHISW TIN PERIPTWSI POU OLES OI MERIES EINAI ADEIES
  int count = 0;

  for (var i = 0; i < tableDirections.length; i++) {
    if (tableDirections[i] == 1) count++;
  }

  if (count == tableDirections.length) return 2;

  if (count == 2 || count == 3) {
    return 1;
  }

  return 0;
}
