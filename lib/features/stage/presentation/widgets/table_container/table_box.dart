// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:find_the_words/core/constants/styles.dart';

class TableBox extends StatelessWidget {
  final String text;

  const TableBox({
    Key? key,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // alignment: Alignment.center,
      // decoration: BoxDecoration(
      //   borderRadius: BorderRadius.circular(borderRadius),
      //   color: Colors.grey,
      // ),
      // margin: const EdgeInsets.all(1),
      // child: Center(
      //   child: Text(
      //     text,
      //     textAlign: TextAlign.center,
      //     overflow: TextOverflow.ellipsis,
      //   ),
      // ),
    );
  }
}
