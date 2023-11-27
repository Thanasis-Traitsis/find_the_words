import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'crossword_table_event.dart';
part 'crossword_table_state.dart';

class CrosswordTableBloc
    extends Bloc<CrosswordTableEvent, CrosswordTableState> {
  CrosswordTableBloc() : super(CrosswordTableState()) {
    on<UpdateWidgetList>(onUpdateWidgetList);
  }

  onUpdateWidgetList(
      UpdateWidgetList event, Emitter<CrosswordTableState> emit) async {
    emit(state.copyWith(widgetList: event.list));
  }
}
