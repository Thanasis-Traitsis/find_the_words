// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'stage_bloc.dart';

sealed class StageEvent extends Equatable {
  const StageEvent();

  @override
  List<Object> get props => [];
}

class StageButtonPressed extends StageEvent {
  final Map stageList;
  final int level;
  final double progress;

  const StageButtonPressed({
    required this.stageList,
    required this.level,
    required this.progress,
  });

  @override
  List<Object> get props => [stageList];

  @override
  String toString() => 'StageButtonPressed(stageList: $stageList)';
}
