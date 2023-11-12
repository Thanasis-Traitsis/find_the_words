List moveTableToCenter({
  required int counterAboveMiddle,
  required int counterBelowMiddle,
  required int counterLeftMiddle,
  required int counterRightMiddle,
  required List<String> tblist,
  required List wordPositions,
}) {
  if (counterAboveMiddle - counterBelowMiddle > 1) {
    print(counterAboveMiddle - counterBelowMiddle);
  }
  if (counterBelowMiddle - counterAboveMiddle > 1) {
    print(counterBelowMiddle - counterAboveMiddle);
  }
  if (counterLeftMiddle - counterRightMiddle > 1) {
    print(counterLeftMiddle - counterRightMiddle);
  }
  if (counterRightMiddle - counterLeftMiddle > 1) {
    for (var i = tblist.length - 2; i >= 0; i--) {
      tblist[i + 1] = tblist[i];
    }

    for (var i = 0; i < wordPositions.length; i++) {
      for (var j = 0; j < wordPositions[i].length; j++) {
        wordPositions[i][j] = wordPositions[i][j] + 1;
      }
    }
  }
  return [tblist, wordPositions];
}
