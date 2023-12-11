import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Future navigateToStage(
  BuildContext context,
  String wordLength,
  List usedStages,
) async {
  var jsonFile = await rootBundle
      .loadString('assets/lists/${wordLength}_letters_list.json');

  List wordsList = jsonDecode(jsonFile)['${wordLength}_letters'];

  // Filter out used stages
  List availableStages = List.from(wordsList)
      .where((stage) => !usedStages.contains(stage.keys.first))
      .toList();

  if (availableStages.isEmpty) {
    return {}; // Indicate that the stage list is exhausted
  }

  // Choose a random map from the available list
  Random random = Random();
  Map<String, dynamic> randomStage =
      availableStages[random.nextInt(availableStages.length)];

  return randomStage;
}
