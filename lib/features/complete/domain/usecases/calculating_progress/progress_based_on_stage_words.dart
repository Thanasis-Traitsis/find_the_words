double progressBasedOnStageWords(int num) {
  if (num < 5) {
    return 0.03;
  }
  if (num < 10) {
    return 0.015;
  }
  if (num < 15) {
    return 0.012;
  }
  if (num < 20) {
    return 0.01;
  }

  return 0.007;
}
