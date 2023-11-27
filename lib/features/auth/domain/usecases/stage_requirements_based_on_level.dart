import '../../../../core/constants/constants.dart';

Map stageRequirementsBasedOnLevel({
  required int level,
  required double progress,
}) {
  // For Stage Length
  var minStageLength = 2;
  var maxStageLength = 3;

  // Amount of big words
  var amountOfBigWords = 1;

  // Length of small words
  var smallWordsLength = 3;

  if (level == 2) {
    if (progress > highProgress) {
      minStageLength = 5;
      maxStageLength = 7;
    } else if (progress > midProgress) {
      minStageLength = 4;
      maxStageLength = 6;
    } else {
      minStageLength = 3;
      maxStageLength = 5;
    }
  }
  if (level == 3) {
    if (progress > highProgress) {
      minStageLength = 5;
      maxStageLength = 8;
    } else if (progress > midProgress) {
      minStageLength = 5;
      maxStageLength = 7;
    } else {
      minStageLength = 4;
      maxStageLength = 6;
    }
  }
  if (level == 4) {
    if (progress > highProgress) {
      minStageLength = 6;
      maxStageLength = 9;
      amountOfBigWords = 2;
    } else if (progress > midProgress) {
      minStageLength = 6;
      maxStageLength = 8;
    } else {
      minStageLength = 5;
      maxStageLength = 6;
    }
  }
  if (level == 5) {
    if (progress > highProgress) {
      minStageLength = 7;
      maxStageLength = 10;
      amountOfBigWords = 2;
    } else if (progress > midProgress) {
      minStageLength = 6;
      maxStageLength = 9;
    } else {
      minStageLength = 5;
      maxStageLength = 7;
    }
  }
  if (level == 6) {
    if (progress > highProgress) {
      minStageLength = 7;
      maxStageLength = 10;
      amountOfBigWords = 2;
      smallWordsLength = 4;
    } else if (progress > midProgress) {
      minStageLength = 7;
      maxStageLength = 9;
    } else {
      minStageLength = 6;
      maxStageLength = 8;
    }
  }
  if (level == 7) {
    if (progress > highProgress) {
      minStageLength = 8;
      maxStageLength = 11;
      amountOfBigWords = 2;
      smallWordsLength = 4;
    } else if (progress > midProgress) {
      minStageLength = 7;
      maxStageLength = 10;
      smallWordsLength = 4;
    } else {
      minStageLength = 6;
      maxStageLength = 8;
      smallWordsLength = 4;
    }
  }
  if (level == 8) {
    if (progress > highProgress) {
      minStageLength = 9;
      maxStageLength = 12;
      amountOfBigWords = 3;
      smallWordsLength = 5;
    } else if (progress > midProgress) {
      minStageLength = 8;
      maxStageLength = 11;
      smallWordsLength = 4;
    } else {
      minStageLength = 7;
      maxStageLength = 10;
      smallWordsLength = 4;
    }
  }

  return {
    "minStageLength": minStageLength,
    "maxStageLength": maxStageLength,
    "amountOfBigWords": amountOfBigWords,
    "smallWordsLength": smallWordsLength,
  };
}
