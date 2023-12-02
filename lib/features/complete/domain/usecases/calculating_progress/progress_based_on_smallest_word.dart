double progressBasedOnSmallestWord(int num) {
  switch (num) {
    case 3:
      return 0.012;
    case 4:
      return 0.01;
    case 5:
      return 0.08;
    case 6:
      return 0.005;
    default:
      return 0.002;
  }
}
