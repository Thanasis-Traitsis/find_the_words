// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:math';

import 'package:find_the_words/features/stage/domain/usecases/answer_usecases/calculate_margin.dart';
import 'package:find_the_words/features/stage/domain/usecases/answer_usecases/change_crossword.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:find_the_words/core/constants/styles.dart';
import 'package:find_the_words/features/stage/domain/usecases/creating_stage/count_padding.dart';
import 'package:find_the_words/features/stage/presentation/widgets/table_container/correct_box.dart';

import '../../answer_bloc/answer_bloc.dart';
import '../../crossword_table_bloc/crossword_table_bloc.dart';

class CrosswordContainer extends StatelessWidget {
  final List<String> tableList;

  const CrosswordContainer({
    Key? key,
    required this.tableList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CrosswordTableBloc, CrosswordTableState>(
      builder: (context, state) {
        List<Widget> wgtList = state.widgetList;

        return BlocBuilder<AnswerBloc, AnswerState>(
          builder: (context, state) {
            changeCrossword(tableList);

            if (state is AnswerCorrect) {
              for (var i = 0; i < state.positions.length; i++) {
                wgtList[state.positions[i]] = CorrectBox(
                  text: tableList[state.positions[i]],
                  tableRowLength: sqrt(wgtList.length).ceil().toDouble(),
                  color: Theme.of(context).colorScheme.primaryContainer,
                  margin: calculateMargin(sqrt(wgtList.length).ceil()),
                  scale: wgtList.length > 80 ? 1.1 : 1.04,
                  delay: i,
                  isCorrect: true,
                );

                if(i == state.positions.length - 1){
                  BlocProvider.of<AnswerBloc>(context).add(AnswerInitialize());
                }
              }
            }
            return Padding(
              padding: EdgeInsets.all(
                countPadding(sqrt(wgtList.length).ceil()),
              ),
              child: Center(
                child: GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  padding: const EdgeInsets.all(padding),
                  shrinkWrap: true,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: sqrt(wgtList.length).ceil(),
                  ),
                  itemCount: wgtList.length,
                  itemBuilder: (context, index) {
                    return wgtList[index];
                  },
                ),
              ),
            );
          },
        );
      },
    );
  }
}
