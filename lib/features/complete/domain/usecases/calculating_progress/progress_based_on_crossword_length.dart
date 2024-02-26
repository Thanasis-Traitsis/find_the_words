double progressBasedOnCrosswordLength(int num) {
  if (num < 3) {
    return 0.015;
  }
  if (num < 5) {
    return 0.01;
  }
  if (num < 7) {
    return 0.008;
  }
  if (num < 10) {
    return 0.006;
  }
  return 0.005;
}
