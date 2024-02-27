part of 'connection_bloc.dart';

sealed class ConnectivityEvent extends Equatable {
  const ConnectivityEvent();

  @override
  List<Object> get props => [];
}

class CheckConnection extends ConnectivityEvent {
  final bool hasConnection;

  const CheckConnection({
    required this.hasConnection,
  });

  @override
  List<Object> get props => [hasConnection];
}