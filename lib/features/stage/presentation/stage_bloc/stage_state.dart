part of 'stage_bloc.dart';

sealed class StageState extends Equatable {
  const StageState();

  @override
  List<Object> get props => [];
}

final class StageInitial extends StageState {}

final class StageLoading extends StageState {}

final class StageStarted extends StageState {
  final List<Widget> widgetList;
  final String letters;

  final List wordPostition;
  final List<String> tableList;
  final List allStageWords;

  const StageStarted({
    required this.wordPostition,
    required this.tableList,
    required this.allStageWords,
    required this.widgetList,
    required this.letters,
  });

  @override
  List<Object> get props => [
        widgetList,
        letters,
        wordPostition,
        tableList,
        allStageWords,
      ];

  @override
  String toString() =>
      'Stage Started(widgetList: $widgetList, letters: $letters)';
}

final class StageFailedCreation extends StageState {
  final List bannedKeys;

  const StageFailedCreation({
    required this.bannedKeys,
  });

  @override
  List<Object> get props => [
        bannedKeys,
      ];

  @override
  String toString() => 'StageFailedCreation( bannedKeys: $bannedKeys)';
}
