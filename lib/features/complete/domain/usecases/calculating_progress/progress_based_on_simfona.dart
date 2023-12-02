import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Future<double> progressBasedOnSimfona(
  BuildContext context,
  String letters,
) async {
  var jsonFile = await rootBundle.loadString('assets/lists/words.json');

  List simfona = jsonDecode(jsonFile)['simfona'];

  List amountOfSimfona = [];

  for (var i = 0; i < letters.length; i++) {
    if (simfona.contains(letters[i])) {
      amountOfSimfona.add(letters[i]);
    }
  }

  double percentage = amountOfSimfona.length / letters.length;

  return percentage * 0.025;
}
