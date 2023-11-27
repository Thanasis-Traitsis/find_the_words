// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../data/repositories/stage_repositories_impl.dart';

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

  void _onStageButtonPressed(
      StageButtonPressed event, Emitter<StageState> emit) async {
    emit(StageLoading());

    var count = 0;

    bool readyForCrossword;

    bool readyForStageScreen = false;

    // Extract the key and the value
    String newKey = event.stageList.keys.first;
    List values = event.stageList[newKey];

    if (newKey != key) {
      while (!readyForStageScreen && count < 5) {
        count++;

        readyForCrossword = await stageRepo.createStage(
          wordsList: values,
          level: event.level,
          progress: event.progress,
        );

        key = newKey;

        if (readyForCrossword) {
          await stageRepo.createCrossword();

          readyForStageScreen = stageRepo.ready;

          if (readyForStageScreen) {
            widgetList = stageRepo.widgetList;

            emit(StageStarted(
              widgetList: widgetList,
              letters: key!,
              wordPostition: stageRepo.wordPositions,
              tableList: stageRepo.tableList,
              allStageWords: values,
            ));
          }
        } else {
          emit(StageFailedCreation());
        }
      }
      if (count == 5) {
        emit(StageFailedCreation());
      }
    } else {
      emit(StageStarted(
        widgetList: widgetList,
        letters: key!,
        wordPostition: stageRepo.wordPositions,
        tableList: stageRepo.tableList,
        allStageWords: values,
      ));
    }
  }
}
