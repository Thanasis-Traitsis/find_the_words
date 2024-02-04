import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:find_the_words/features/stage/data/repositories/answer_repositories_impl.dart';

part 'answer_event.dart';
part 'answer_state.dart';

class AnswerBloc extends Bloc<AnswerEvent, AnswerState> {
  final AnswerRepositoriesImpl answerRepo;

  AnswerBloc({
    required this.answerRepo,
  }) : super(AnswerInitial()) {
    on<AnswerLetterHover>(onAnswerLetterHover);
    on<AnswerCompleted>(onAnswerCompleted);
    on<HintCalled>(onHintCalled);
    on<AnswerInitialize>(onAnswerInitialize);
  }

  String answerWord = '';

  void onAnswerLetterHover(
      AnswerLetterHover event, Emitter<AnswerState> emit) async {
    emit(AnswerCreation());

    String answer = answerWord;

    answer += event.letter;

    answerWord = answer;

    emit(AnswerComplete(
      answer: answer,
    ));
  }

  void onAnswerCompleted(
      AnswerCompleted event, Emitter<AnswerState> emit) async {
    List? correctAnswer = await answerRepo.submitAnswer(
      answer: answerWord,
      wordPositions: event.stageMap['wordPositions'],
      tableList: event.stageMap['tableList'],
      allStageWords: event.stageMap['allStageWords'],
      answeredPositions: event.answeredPositions['answeredPositions'],
      answeredWords: event.answeredPositions['answeredWords'],
    );

    if (correctAnswer != null) {
      if (correctAnswer.isEmpty) {
        emit(
          AnswerIsExtraWord(
            word: answerWord,
          ),
        );
      } else {
        emit(
          AnswerCorrect(
            positions: correctAnswer,
            word: answerWord,
          ),
        );
      }

      answerWord = '';
    } else {
      answerWord = '';

      emit(AnswerComplete(
        answer: answerWord,
      ));
    }
  }

  void onHintCalled(HintCalled event, Emitter<AnswerState> emit) async {
    emit(AnswerCreation());

    if (event.stageMap['wordPositions'].length !=
        event.answeredPositions['answeredPositions'].length) {
      List? hintPosition = await answerRepo.positionHintLetter(
        wordPositions: event.stageMap['wordPositions'],
        tableList: event.stageMap['tableList'],
        answeredPositions: event.answeredPositions['answeredPositions'],
        unavailablePositions: event.answeredPositions['unavailablePositions'],
      );

      if (hintPosition != null) {
        emit(
          AnswerCorrect(
            positions: hintPosition[0],
            word: hintPosition[1],
          ),
        );
      }
    }
  }

  void onAnswerInitialize(
      AnswerInitialize event, Emitter<AnswerState> emit) async {
    emit(AnswerInitial());
  }
}
