part of 'points_bloc.dart';

class PointsState extends Equatable {
  const PointsState({
    int? points,
  }) : points = points ?? 0;

  final int points;

  @override
  List<Object> get props => [points];

  PointsState copyWith({int? points}) {
    return PointsState(
      points: points ?? this.points,
    );
  }
}
