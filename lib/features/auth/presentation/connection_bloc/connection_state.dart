part of 'connection_bloc.dart';

class ConnectivityState extends Equatable {
  const ConnectivityState({
    bool? hasConnection,
  }) : hasConnection = hasConnection ?? false;

  final bool hasConnection;

  @override
  List<Object> get props => [hasConnection];

  ConnectivityState copyWith({bool? hasConnection}) {
    return ConnectivityState(
      hasConnection: hasConnection ?? this.hasConnection,
    );
  }
}
