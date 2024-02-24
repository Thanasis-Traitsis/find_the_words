part of 'sound_bloc.dart';

sealed class SoundEvent extends Equatable {
  const SoundEvent();

  @override
  List<Object> get props => [];
}

class ChangeSound extends SoundEvent {}