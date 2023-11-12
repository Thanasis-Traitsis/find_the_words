import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../data/models/user_model.dart';
import '../../data/repositories/auth_repositories_impl.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepositoriesImpl authRepo;

  AuthBloc({
    required this.authRepo,
  }) : super(AuthInitial()) {
    on<AppStarted>(_onAppStarted);
  }

  void _onAppStarted(AppStarted event, Emitter<AuthState> emit) async {
    emit(AuthLoading());

    await authRepo.getUser();

    if (authRepo.user != null) {
      emit(
        AuthAuthenticated(
          user: authRepo.user!,
        ),
      );
    } else {
      emit(AuthUnauthenticated());
    }
  }
}
