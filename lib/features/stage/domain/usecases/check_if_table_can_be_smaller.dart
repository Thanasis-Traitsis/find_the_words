int checkIfTableCanBeSmaller({
  required List tableDirections,
  required int tableRowsAndColumns,
}) {
  int count = 0;

  for (var i = 0; i < tableDirections.length; i++) {
    if(tableDirections[i] == 1) count++;
  }

  if(count == tableDirections.length) return 2;

  return 0;
}
