// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../../../../core/constants/constants.dart';
import '../../../../current_stage.dart';
import '../../data/repositories/stage_repositories_impl.dart';
import '../../domain/usecases/creating_crossword/apply_changes.dart';
import '../../domain/usecases/creating_crossword/generate_widget_table.dart';

part 'stage_event.dart';
part 'stage_state.dart';

class StageBloc extends Bloc<StageEvent, StageState> {
  final StageRepositoriesImpl stageRepo;

  StageBloc({
    required this.stageRepo,
  }) : super(StageInitial()) {
    on<StageButtonPressed>(_onStageButtonPressed);
  }

  List<Widget> widgetList = [];
  String? key;

  List bannedKeys = [];

  void _onStageButtonPressed(
      StageButtonPressed event, Emitter<StageState> emit) async {
    emit(StageLoading());

    var stageBox = Hive.box<CurrentStage>(currentStageBox);
    var stage = stageBox.get(currentStageBox);

    key = stage!.key;

    if (key == null || key == '') {
      var count = 0;
      bool readyForCrossword = true;
      bool readyForStageScreen = false;

      // Extract the key and the value
      String newKey = event.stageList.keys.first;
      List values = event.stageList[newKey];

      print(
          '3. ======================================================================================================');
      print('THIS IS WHERE THE FUN BEGINS');
      print('KEY : $newKey');
      print('WORDS : $values');

      key = newKey;

      readyForCrossword = await stageRepo.createStage(
        wordsList: values,
        level: event.level,
        progress: event.progress,
      );

      print('THIS IS READY : $readyForCrossword');

      if (readyForCrossword) {
        while (!readyForStageScreen && count < 5) {
          if (count != 0) {
            await stageRepo.createStage(
              wordsList: values,
              level: event.level,
              progress: event.progress,
            );
          }
          count++;

          if (count == 5) {
            bannedKeys.add(key);

            print('MIPOS FTAEI AYTO TO SHMEIOOOOO');

            emit(StageFailedCreation(
              bannedKeys: bannedKeys,
            ));
          } else {
            await stageRepo.createCrossword();

            readyForStageScreen = stageRepo.ready;
          }

          if (readyForStageScreen) {
            widgetList = stageRepo.widgetList;

            bannedKeys = [];

            stageBox.put(
              currentStageBox,
              CurrentStage(
                answeredPositions: stage.answeredPositions,
                answeredWords: stage.answeredWords,
                unavailablePositions: stage.unavailablePositions,
                key: key,
                allStageWords: values,
                tableList: stageRepo.tableList,
                wordPositions: stageRepo.wordPositions,
                timerOfStage: stage.timerOfStage,
              ),
            );

            emit(StageStarted(
              widgetList: widgetList,
              letters: key!,
              wordPostition: stageRepo.wordPositions,
              tableList: stageRepo.tableList,
              allStageWords: values,
            ));
          }
        }
      } else {
        bannedKeys.add(key);

        emit(StageFailedCreation(
          bannedKeys: bannedKeys,
        ));
      }
    } else {
      widgetList = generateWidgetTable(stage.tableList!.length);

      widgetList = await getCurrentWidgetList(
        allUnavailablePositions: stage.unavailablePositions,
        positions: stage.wordPositions!,
        tbList: stage.tableList!,
        wdtList: widgetList,
      );

      print(stage.unavailablePositions);
      print(stage.wordPositions!);
      print(stage.tableList!);
      print(widgetList.length);

      emit(StageStarted(
        widgetList: widgetList,
        letters: key!,
        wordPostition: stage.wordPositions!,
        tableList: stage.tableList!,
        allStageWords: stage.allStageWords!,
      ));
    }
  }
}
