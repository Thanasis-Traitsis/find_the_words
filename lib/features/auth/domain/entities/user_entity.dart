// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String? id;
  final int? level;
  final int? stage;
  final List? words;
  final List? extraWords;
  final int? points;
  final double? progress;
  final List? usedStages;
  final Map? currentStage;

  const UserEntity({
    this.id,
    this.level,
    this.stage,
    this.words,
    this.extraWords,
    this.points,
    this.progress,
    this.usedStages,
    this.currentStage,
  });

  @override
  List<Object?> get props => [
        id,
        level,
        stage,
        words,
        extraWords,
        points,
        progress,
        usedStages,
        currentStage,
      ];
}
