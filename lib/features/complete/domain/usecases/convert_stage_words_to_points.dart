int convertStageWordsToPoints(int wordsLength) {
  if(wordsLength < 3) {
    return 1;
  }
  if(wordsLength < 5) {
    return 2;
  }
  if(wordsLength < 8) {
    return 3;
  }
  if(wordsLength < 10) {
    return 4;
  }

  return 4;
}