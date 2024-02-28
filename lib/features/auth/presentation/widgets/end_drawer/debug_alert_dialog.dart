import 'package:find_the_words/features/auth/presentation/widgets/end_drawer/copy_email_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../../core/constants/constants.dart';
import '../../../../../core/constants/styles.dart';
import '../../../../../core/usecases/calculate_size.dart';

AlertDialog DebugAlertDialog({
  required BuildContext context,
}) {
  return AlertDialog(
    title: Text(
      'Συνάντησες κάποιο πρόβλημα;',
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: calculateSize(
          context,
          Theme.of(context).textTheme.headlineLarge!.fontSize!,
        ),
      ),
    ),
    content: Text(
      'Αν αντιμετωπίζεις κάποιο πρόβλημα ή έχεις ανακαλύψει ένα σφάλμα στην εφαρμογή, παρακαλώ στείλε ένα email στη διεύθυνση $myEmail για να μας βοηθήσεις να βελτιώσουμε την εμπειρία των παικτών. Σε ευχαριστοώ για την υποστήριξή σου!',
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
        onPressed: () async {
          Navigator.of(context).pop();
        },
      ),
      const CopyEmailButton(),
    ],
  );
}
