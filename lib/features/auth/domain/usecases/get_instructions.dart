import 'dart:convert';

import 'package:flutter/services.dart';

Future getInstructions() async {
  var instructions =
      await rootBundle.loadString('assets/instructions/instructions.json');

  var details = jsonDecode(instructions)['instructions'];

  return details;
}
