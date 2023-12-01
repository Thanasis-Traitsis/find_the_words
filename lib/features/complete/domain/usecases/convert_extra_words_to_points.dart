int convertExtraWordsToPoints(int extraLength) {
  if (extraLength < 1) {
    return 0;
  }
  if (extraLength < 5) {
    return 1;
  }
  if (extraLength < 10) {
    return 2;
  }

  return 3;
}
