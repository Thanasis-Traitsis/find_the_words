int calculatingPointsForLevelUp(int lvl) {
  switch (lvl) {
    case 1:
      return 20;
    case 2:
      return 25;
    case 3:
      return 30;
    case 4:
      return 50;
    case 5:
      return 75;
    case 6:
      return 100;
    default:
      return 150;
  }
}
