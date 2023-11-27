String translateLevelToStage(int level) {
  switch (level) {
    case 1:
      return 'three';
    case 2:
      return 'four';
    case 3:
      return 'five';
    case 4:
      return 'six';
    case 5:
      return 'seven';
    case 6:
      return 'eight';
    case 7:
      return 'nine';
    default :
      return 'ten';
  }
}
