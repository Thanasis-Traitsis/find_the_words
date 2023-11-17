import 'package:flutter/material.dart';

abstract class CrosswordRepositories {
  Future placeWords({
    required List<Widget> widgetList,
    required List<String> tableList,
    required int numberOfRowsAndColumns,
    required List<String> wordsList,
    required List listOfStartingPositions,
  });

  Future fillTableWithWords(List listOfStartingPositions);
}
