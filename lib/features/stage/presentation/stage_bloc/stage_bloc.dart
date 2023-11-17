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

  void _onStageButtonPressed(
      StageButtonPressed event, Emitter<StageState> emit) async {
    emit(StageLoading());

    bool readyForCrossword;

    // Extract the key and the value
    String key = event.stageList.keys.first;
    List values = event.stageList[key];

    readyForCrossword = await stageRepo.createStage(values);

    if (readyForCrossword) {
      await stageRepo.createCrossword();

      emit(StageStarted(tableList: stageRepo.widgetList));
    }
  }
}
