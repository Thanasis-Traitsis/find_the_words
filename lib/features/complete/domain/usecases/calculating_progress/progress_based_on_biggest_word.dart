double progressBasedOnBiggestWord(int num) {
  switch (num) {
    case 3:
      return 0.02;
    case 4:
      return 0.015;
    case 5:
      return 0.012;
    case 6:
      return 0.01;
    case 7:
      return 0.01;
    case 8:
      return 0.008;
    case 9:
      return 0.006;
    default:
      return 0.005;
  }
}
