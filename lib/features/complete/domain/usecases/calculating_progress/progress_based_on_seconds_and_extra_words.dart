double progressBasedOnSecondsAndExtraWords({
  required int seconds,
  required int extraWords,
}) {
  print('THE STAGE TOOK ${seconds} SECONDS');

  if (seconds < 10) {
    return 1.25;
  }
  if (seconds < 30) {
    if (extraWords > 0) {
      return 1.25;
    }

    return 1.15;
  }
  if (seconds < 60) {
    if (extraWords > 0) {
      return 1.2;
    }

    return 1.1;
  }
  if (seconds < 180) {
    if (extraWords > 0) {
      return 1.1;
    }

    return 1;
  }
  if (seconds < 300) {
    if (extraWords > 0) {
      return 1;
    } else if (extraWords > 3) {
      return 1.1;
    } else if (extraWords > 5) {
      return 1.15;
    }

    return 0.8;
  }

  return 0.5;
}
