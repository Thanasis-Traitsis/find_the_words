part of 'crossword_table_bloc.dart';

class CrosswordTableState extends Equatable {
  CrosswordTableState({
    List<Widget>? widgetList,
  }) : widgetList = widgetList ?? [];

  final List<Widget> widgetList;

  @override
  List<Object> get props => [widgetList];

  CrosswordTableState copyWith({List<Widget>? widgetList}) {
    return CrosswordTableState(
      widgetList: widgetList ?? this.widgetList,
    );
  }
}
