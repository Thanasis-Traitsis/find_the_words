import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:equatable/equatable.dart';

part 'connection_event.dart';
part 'connection_state.dart';

class ConnectivityBloc extends Bloc<ConnectivityEvent, ConnectivityState> {
  ConnectivityBloc() : super(const ConnectivityState()) {
    on<CheckConnection>(onCheckConnection);
  }

  ConnectivityResult connection = ConnectivityResult.none;

  onCheckConnection(
      CheckConnection event, Emitter<ConnectivityState> emit) async {
    emit(state.copyWith(hasConnection: event.hasConnection));
  }
}
