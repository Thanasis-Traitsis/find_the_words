import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/constants/constants.dart';

part 'points_event.dart';
part 'points_state.dart';

class PointsBloc extends Bloc<PointsEvent, PointsState> {
  PointsBloc() : super(const PointsState()) {
    on<ChangePoints>(onChangePoints);
    on<GetPoints>(onGetPoints);
  }

  onChangePoints(ChangePoints event, Emitter<PointsState> emit) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.setInt(
        userPoints,
        event.isMinus
            ? state.points - event.points
            : state.points + event.points);

    emit(
      state.copyWith(
        points: event.isMinus
            ? state.points - event.points
            : state.points + event.points,
      ),
    );
  }

  onGetPoints(GetPoints event, Emitter<PointsState> emit) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    int? points = prefs.getInt(userPoints);

    print(points);

    points ??= 0;

    emit(
      state.copyWith(
        points: points,
      ),
    );
  }
}
