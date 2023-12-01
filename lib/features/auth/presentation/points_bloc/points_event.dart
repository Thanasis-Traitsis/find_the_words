// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'points_bloc.dart';

sealed class PointsEvent extends Equatable {
  const PointsEvent();

  @override
  List<Object> get props => [];
}

class ChangePoints extends PointsEvent {
  final int points;
  final bool isMinus;

  const ChangePoints({
    required this.points,
    required this.isMinus,
  });

  @override
  List<Object> get props => [points, isMinus];
}

class GetPoints extends PointsEvent {}
