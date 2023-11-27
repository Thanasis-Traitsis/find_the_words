part of 'letters_bloc.dart';

class LettersState extends Equatable {
  const LettersState({
    String? letters,
  }) : letters = letters ?? '';

  final String letters;

  @override
  List<Object> get props => [letters];

  LettersState copyWith({String? letters}) {
    return LettersState(
      letters: letters ?? this.letters,
    );
  }
}
