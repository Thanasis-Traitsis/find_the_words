part of 'sound_bloc.dart';

class SoundState extends Equatable {
  SoundState({
    bool? hasSound,
  }) : hasSound = hasSound ?? true;

  final bool hasSound;

  @override
  List<Object> get props => [hasSound];

  SoundState copyWith({bool? hasSound}) {
    return SoundState(
      hasSound: hasSound ?? this.hasSound,
    );
  }
}
