import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../letters_bloc/letters_bloc.dart';
import '../scrollable_bloc/scrollable_bloc.dart' as scroll;
import '../widgets/appbar/points_container.dart';
import '../widgets/appbar/title_of_appbar.dart';
import '../widgets/buttons_with_circle_letters_section.dart';
import '../widgets/table_container/crossword_container.dart';

class StageScreen extends StatelessWidget {
  final String stage;
  final Map stageMap;
  final Map answeredPositions;

  StageScreen({
    Key? key,
    required this.stage,
    required this.stageMap,
    required this.answeredPositions,
  }) : super(key: key);

  bool creatingWord = false;

  @override
  Widget build(BuildContext context) {
    String answer = '';

    return Scaffold(
      appBar: AppBar(
        title: TitleOfAppbar(
          context: context,
          stage: stage,
        ),
        actions: [
          PointsContainer(
            context: context,
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: true
              ? const NeverScrollableScrollPhysics()
              : const PageScrollPhysics(),
          child: Column(
            children: [
              CrosswordContainer(
                tableList: stageMap['tableList'],
              ),
              BlocBuilder<LettersBloc, LettersState>(
                builder: (context, state) {
                  return ButtonsWithCircleLettersSection(
                    letters: state.letters,
                    answer: answer,
                    stageMap: stageMap,
                    answeredPositions: answeredPositions,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
