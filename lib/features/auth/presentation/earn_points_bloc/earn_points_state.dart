part of 'earn_points_bloc.dart';

sealed class EarnPointsState extends Equatable {
  const EarnPointsState();

  @override
  List<Object> get props => [];
}

final class EarnPointsInitial extends EarnPointsState {}

final class EarnPointsLoading extends EarnPointsState {}

final class EarnPointsCanWatch extends EarnPointsState {}

final class EarnPointsTooEarly extends EarnPointsState {
  final Duration timer;

  const EarnPointsTooEarly({
    required this.timer,
  });

  @override
  List<Object> get props => [
        timer,
      ];

  @override
  String toString() => 'EarnPointsTooEarly(timer: $timer)';
}
