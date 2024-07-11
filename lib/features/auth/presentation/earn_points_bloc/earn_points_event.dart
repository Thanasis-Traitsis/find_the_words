part of 'earn_points_bloc.dart';

sealed class EarnPointsEvent extends Equatable {
  const EarnPointsEvent();

  @override
  List<Object> get props => [];
}

class WatchAd extends EarnPointsEvent { 
  final bool loadedAd;

  const WatchAd({
    required this.loadedAd,
  });

  @override
  List<Object> get props => [loadedAd];
 }
