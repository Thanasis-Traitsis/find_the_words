import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../../core/constants/constants.dart';
import '../../../../../core/constants/styles.dart';
import '../../../../../core/usecases/calculate_size.dart';

class CopyEmailButton extends StatefulWidget {
  const CopyEmailButton({super.key});

  @override
  State<CopyEmailButton> createState() => _CopyEmailButtonState();
}

class _CopyEmailButtonState extends State<CopyEmailButton> {
  bool isCopied = false;

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      style: TextButton.styleFrom(
        padding: const EdgeInsets.symmetric(
            horizontal: padding * 1.5, vertical: padding / 2),
        backgroundColor: isCopied
            ? Theme.of(context).canvasColor
            : Theme.of(context).colorScheme.primary,
        textStyle: Theme.of(context).textTheme.labelLarge,
      ),
      child: Text(
        isCopied ? 'Αντιγράφηκε' : 'Αντιγραφή Email',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: isCopied
              ? Theme.of(context).colorScheme.outline
              : Theme.of(context).colorScheme.surface,
          fontSize: calculateSize(
            context,
            Theme.of(context).textTheme.bodyMedium!.fontSize!,
          ),
        ),
      ),
      onPressed: () async {
        await Clipboard.setData(
          const ClipboardData(
            text: myEmail,
          ),
        );

        setState(() {
          isCopied = true;
        });
      },
    );
  }
}
