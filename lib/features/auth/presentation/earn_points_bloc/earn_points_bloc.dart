import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/constants/game_values.dart';

part 'earn_points_event.dart';
part 'earn_points_state.dart';

class EarnPointsBloc extends Bloc<EarnPointsEvent, EarnPointsState> {
  EarnPointsBloc() : super(EarnPointsInitial()) {
    on<WatchAd>(onWatchAd);
  }

  onWatchAd(WatchAd event, Emitter<EarnPointsState> emit) async {
    emit(EarnPointsLoading());

    if (event.loadedAd) {
      final SharedPreferences prefs = await SharedPreferences.getInstance();

      bool? isFirstTime = prefs.getBool('firstAd');

      isFirstTime ??= true;

      if (isFirstTime) {
        emit(EarnPointsCanWatch());

        prefs.setString('startTime', DateTime.now().toString());
        prefs.setBool('firstAd', false);
      } else {
        DateTime startTime = DateTime.parse(prefs.getString('startTime')!);
        DateTime now = DateTime.now();
        Duration timeLeft = startTime.difference(now);

        if (startTime
            .add(const Duration(hours: earnPointsTimer))
            .isBefore(DateTime.now())) {
          emit(EarnPointsCanWatch());

          prefs.setString('startTime', DateTime.now().toString());
        } else {
          emit(EarnPointsTooEarly(
            timer: timeLeft,
          ));
        }
      }
    } else {
      emit(EarnPointsFailed());
    }
  }
}
