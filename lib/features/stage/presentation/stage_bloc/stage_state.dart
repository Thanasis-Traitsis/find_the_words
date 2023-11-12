part of 'stage_bloc.dart';

sealed class StageState extends Equatable {
  const StageState();
  
  @override
  List<Object> get props => [];
}

final class StageInitial extends StageState {}

final class StageLoading extends StageState {}

final class StageStarted extends StageState {
  final List<Widget> tableList;

  const StageStarted({
    required this.tableList,
  });

  @override
  List<Object> get props => [tableList];

  @override
  String toString() => 'Stage Started(tableList: $tableList)';
}
