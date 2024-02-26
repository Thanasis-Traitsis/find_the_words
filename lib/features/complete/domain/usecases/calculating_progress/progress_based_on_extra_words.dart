double progressBasedOnExtraWords(int num) {
  if (num > 8) {
    return 0.015;
  }
  if (num > 4) {
    return 0.01;
  }
  if (num > 2) {
    return 0.008;
  }
  if (num > 0) {
    return 0.005;
  }

  return 0;
}
