part of 'version_bloc.dart';

class VersionState extends Equatable {
  const VersionState({
    String? version,
  }) : version = version ?? '';

  final String version;

  @override
  List<Object> get props => [version];

  VersionState copyWith({String? version}) {
    return VersionState(
      version: version ?? this.version,
    );
  }
}
