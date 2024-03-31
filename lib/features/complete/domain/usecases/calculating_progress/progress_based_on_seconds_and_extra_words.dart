double progressBasedOnSecondsAndExtraWords({
  required int seconds,
  required int extraWords,
  required int level,
}) {
  print('THE STAGE TOOK ${seconds} SECONDS');

  if (seconds < 30) {
    return 1.25;
  }
  if (seconds < 60) {
    if (extraWords > 0) {
      return 1.25;
    }

    return 1.15;
  }
  if (seconds < 180) {
    if (extraWords > 0) {
      return 1.2;
    }

    return 1.1;
  }
  if (seconds < 450) {
    if (extraWords > 0 || level > 5) {
      return 1.1;
    }

    return 1;
  }
  if (seconds < 900) {
    if (extraWords > 5 && level > 6) {
      return 1.2;
    }
    if (extraWords > 3 && level > 4) {
      return 1.15;
    }
    if (extraWords > 5) {
      return 1.15;
    } else if (extraWords > 3) {
      return 1.1;
    } else if (extraWords > 0) {
      return 1;
    }

    return 0.8;
  }

  return 0.5;
}
