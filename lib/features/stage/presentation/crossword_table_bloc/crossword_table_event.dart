part of 'crossword_table_bloc.dart';

sealed class CrosswordTableEvent extends Equatable {
  const CrosswordTableEvent();

  @override
  List<Object> get props => [];
}

class UpdateWidgetList extends CrosswordTableEvent {
  final List<Widget> list;

  const UpdateWidgetList({
    required this.list,
  });

  @override
  List<Object> get props => [list];
}