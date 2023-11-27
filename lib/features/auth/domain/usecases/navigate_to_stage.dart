import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Future navigateToStage(BuildContext context, String wordLength) async {
  var jsonFile = await rootBundle
      .loadString('assets/lists/${wordLength}_letters_list.json');

  List wordsList = jsonDecode(jsonFile)['${wordLength}_letters'];

  // Choose a random map from the list
  Random random = Random();
  Map<String, dynamic> randomStage =
      wordsList[random.nextInt(wordsList.length)];

  return randomStage;
}
