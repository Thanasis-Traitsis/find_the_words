import '../../domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  const UserModel({
    String? id,
    int? level,
    int? stage,
    List? words,
    List? extraWords,
    int? points,
    double? progress,
  }) : super(
          id: id,
          level: level,
          stage: stage,
          words: words,
          extraWords: extraWords,
          points: points,
          progress: progress,
        );
}
