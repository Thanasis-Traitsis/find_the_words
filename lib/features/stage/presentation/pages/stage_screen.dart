// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/constants.dart';
import '../../../../core/utils/breakpoints_utils.dart';
import '../../../../core/utils/routes_utils.dart';
import '../../../../core/widgets/absorb_pointer_container.dart';
import '../../../auth/data/models/user_model.dart';

import '../letters_bloc/letters_bloc.dart';
import '../stage_scroll_bloc/stage_scroll_bloc.dart';
import '../widgets/appbar/points_container.dart';
import '../widgets/appbar/title_of_appbar.dart';
import '../widgets/buttons_with_circle_letters_section.dart';
import '../widgets/table_container/crossword_container.dart';

class StageScreen extends StatelessWidget {
  final UserModel user;
  final String stage;
  final Map stageMap;
  final Map answeredPositions;

  StageScreen({
    Key? key,
    required this.user,
    required this.stage,
    required this.stageMap,
    required this.answeredPositions,
  }) : super(key: key);

  bool creatingWord = false;

  @override
  Widget build(BuildContext context) {
    final deviceOrientation = getDeviceOrientation(context);
    String answer = '';
    int timerValue = answeredPositions[currentTimer] ??= 0;

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
      body: WillPopScope(
        onWillPop: () async {
          context.goNamed(
            PAGES.home.screenName,
            extra: user,
          );

          return false;
        },
        child: AbsorbPointerContainer(
          context: context,
          child: SafeArea(
            child: deviceOrientation == DeviceOrientation.portrait
                ? BlocBuilder<StageScrollBloc, StageScrollState>(
                    builder: (context, state) {
                      return SingleChildScrollView(
                        physics: state.scrollable
                            ? const ScrollPhysics()
                            : const NeverScrollableScrollPhysics(),
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
                                  timerValue: timerValue,
                                );
                              },
                            ),
                          ],
                        ),
                      );
                    },
                  )
                : Row(
                    children: [
                      Expanded(
                        child: SingleChildScrollView(
                          child: CrosswordContainer(
                            tableList: stageMap['tableList'],
                          ),
                        ),
                      ),
                      Expanded(
                        child: BlocBuilder<LettersBloc, LettersState>(
                          builder: (context, state) {
                            return ButtonsWithCircleLettersSection(
                              letters: state.letters,
                              answer: answer,
                              stageMap: stageMap,
                              answeredPositions: answeredPositions,
                              timerValue: timerValue,
                            );
                          },
                        ),
                      ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}
