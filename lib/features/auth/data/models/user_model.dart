import '../../domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  const UserModel({
    String? id,
    int? level,
    int? stage,
    List? words,
    int? points,
    double? progress,
    List? usedStages,
  }) : super(
          id: id,
          level: level,
          stage: stage,
          words: words,
          points: points,
          progress: progress,
          usedStages: usedStages,
        );
}
