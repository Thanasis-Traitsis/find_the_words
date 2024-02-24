import 'package:find_the_words/core/constants/styles.dart';
import 'package:flutter/material.dart';

import 'drawer_section_header.dart';

Widget DrawerSection({
  required BuildContext context,
  required String header,
  required List<Widget> widgets,
}) {
  return Container(
    margin: const EdgeInsets.only(top: gap),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DrawerSectionHeader(
          context: context,
          text: header,
        ),
        const SizedBox(
          height: gap / 3,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: widgets,
        )
      ],
    ),
  );
}
