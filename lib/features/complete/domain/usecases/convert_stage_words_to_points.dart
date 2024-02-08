int convertStageWordsToPoints(int wordsLength) {
  if(wordsLength < 3) {
    return 0;
  }
  if(wordsLength < 6) {
    return 1;
  }
  if(wordsLength < 8) {
    return 2;
  }
  if(wordsLength < 12) {
    return 3;
  }

  return 4;
}