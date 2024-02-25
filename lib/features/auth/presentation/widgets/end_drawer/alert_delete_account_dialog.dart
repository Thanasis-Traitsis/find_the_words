import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../../core/constants/styles.dart';
import '../../../../../core/usecases/calculate_size.dart';
import '../../../data/repositories/auth_repositories_impl.dart';

AlertDialog AlertDeleteAccountDialog({
  required BuildContext context,
}) {
  return AlertDialog(
    title: Text(
      'Διαγραφή Λογαριασμού',
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: calculateSize(
          context,
          Theme.of(context).textTheme.headlineLarge!.fontSize!,
        ),
      ),
    ),
    content: Text(
      'Εκτελώντας αυτή την ενέργεια, θα διαγράψεις τη συνολική σου πρόοδο. Αν επιλέξεις να ξαναπαίξεις, θα ξεκινήσεις από την αρχή. Θες να προχωρήσεις στη διαγραφή του λογαριασμού σου;',
      style: TextStyle(
        fontSize: calculateSize(
          context,
          Theme.of(context).textTheme.bodyLarge!.fontSize!,
        ),
      ),
    ),
    actions: <Widget>[
      FilledButton(
        style: TextButton.styleFrom(
          padding: const EdgeInsets.symmetric(
              horizontal: padding * 1.5, vertical: padding / 2),
          backgroundColor: Theme.of(context).colorScheme.primary,
          textStyle: Theme.of(context).textTheme.labelLarge,
        ),
        child: Text(
          'Άκυρο',
          style: TextStyle(
            fontWeight: FontWeight.bold,
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
      TextButton(
        style: TextButton.styleFrom(
          textStyle: Theme.of(context).textTheme.labelLarge,
        ),
        child: Text(
          'Επιβεβαίωση',
          style: TextStyle(
            fontSize: calculateSize(
              context,
              Theme.of(context).textTheme.bodyMedium!.fontSize!,
            ),
          ),
        ),
        onPressed: () async {
          await AuthRepositoriesImpl().deleteUser();

          if (Platform.isAndroid) {
            SystemNavigator.pop();
          } else if (Platform.isIOS) {
            exit(0);
          }
        },
      ),
    ],
  );
}
