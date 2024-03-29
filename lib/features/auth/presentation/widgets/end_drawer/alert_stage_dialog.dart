import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../core/constants/constants.dart';
import '../../../../../core/constants/styles.dart';
import '../../../../../core/usecases/calculate_size.dart';
import '../../../../../current_stage.dart';

AlertDialog AlertStageDialog({
  required BuildContext context,
}) {
  return AlertDialog(
    title: Text(
      'Διαγραφή Σταδίου',
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: calculateSize(
          context,
          Theme.of(context).textTheme.headlineLarge!.fontSize!,
        ),
      ),
    ),
    content: Text(
      'ΠΡΟΣΟΧΗ! Αν διαγράψεις το στάδιο, θα χάσεις την πρόοδου σου και θα ξεκινήσει ένα νέο στάδιο από την αρχή.',
      style: TextStyle(
        fontSize: calculateSize(
          context,
          Theme.of(context).textTheme.bodyLarge!.fontSize!,
        ),
      ),
    ),
    actions: <Widget>[
      TextButton(
        style: TextButton.styleFrom(
          textStyle: Theme.of(context).textTheme.labelLarge,
        ),
        child: Text(
          'Άκυρο',
          style: TextStyle(
            fontSize: calculateSize(
              context,
              Theme.of(context).textTheme.bodyMedium!.fontSize!,
            ),
          ),
        ),
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
      FilledButton(
        style: TextButton.styleFrom(
          padding: const EdgeInsets.symmetric(
              horizontal: padding * 1.5, vertical: padding / 2),
          backgroundColor: Theme.of(context).colorScheme.primary,
          textStyle: Theme.of(context).textTheme.labelLarge,
        ),
        child: Text(
          'Διαγραφή',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: calculateSize(
              context,
              Theme.of(context).textTheme.bodyMedium!.fontSize!,
            ),
          ),
        ),
        onPressed: () async {
          final SharedPreferences prefs = await SharedPreferences.getInstance();

          prefs.setStringList(extraWordsList, []);

          var stageBox = Hive.box<CurrentStage>(currentStageBox);
          await stageBox.delete(currentStageBox);

          Navigator.of(context).pop();
        },
      ),
    ],
  );
}
