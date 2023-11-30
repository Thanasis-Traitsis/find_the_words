import 'package:find_the_words/config/theme/colors.dart';
import 'package:find_the_words/config/theme/theme.dart';
import 'package:find_the_words/core/constants/sizes.dart';
import 'package:find_the_words/current_stage.dart';
import 'package:find_the_words/features/auth/presentation/auth_bloc/auth_bloc.dart';
import 'package:find_the_words/features/stage/presentation/letters_circle_bloc/letters_circle_bloc.dart';
import 'package:find_the_words/features/stage/presentation/scrollable_bloc/scrollable_bloc.dart';
import 'package:find_the_words/features/stage/presentation/stage_bloc/stage_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'config/routes/routes.dart';
import 'core/constants/constants.dart';
import 'features/auth/data/repositories/auth_repositories_impl.dart';
import 'features/stage/data/repositories/answer_repositories_impl.dart';
import 'features/stage/data/repositories/stage_repositories_impl.dart';
import 'features/stage/presentation/answer_bloc/answer_bloc.dart';
import 'features/stage/presentation/crossword_table_bloc/crossword_table_bloc.dart';
import 'features/stage/presentation/letters_bloc/letters_bloc.dart';
import 'firebase_options.dart';

Future<void> main() async {
  await Hive.initFlutter();

  Hive.registerAdapter(CurrentStageAdapter());
  await Hive.openBox<CurrentStage>(currentStageBox);

  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  final authRepositoriesImpl = AuthRepositoriesImpl();
  final stageRepositoriesImpl = StageRepositoriesImpl();
  final answerRepositoriesImpl = AnswerRepositoriesImpl();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (context) {
            return AuthBloc(authRepo: authRepositoriesImpl)..add(AppStarted());
          },
        ),
        BlocProvider<StageBloc>(
          create: (context) {
            return StageBloc(stageRepo: stageRepositoriesImpl);
          },
        ),
        BlocProvider<LettersBloc>(
          create: (context) {
            return LettersBloc();
          },
        ),
        BlocProvider<ScrollableBloc>(
          create: (context) {
            return ScrollableBloc();
          },
        ),
        BlocProvider<CrosswordTableBloc>(
          create: (context) {
            return CrosswordTableBloc();
          },
        ),
        BlocProvider<LettersCircleBloc>(
          create: (context) {
            return LettersCircleBloc();
          },
        ),
        BlocProvider<AnswerBloc>(
          create: (context) {
            return AnswerBloc(answerRepo: answerRepositoriesImpl);
          },
        )
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final scaffoldKey = GlobalKey<ScaffoldMessengerState>();
    final navigatorKey = GlobalKey<NavigatorState>();

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      scaffoldMessengerKey: scaffoldKey,
      title: 'Βρες τις λέξεις',
      routerConfig: AppRouter(
        scaffoldMessengerKey: scaffoldKey,
        rootNavigatorKey: navigatorKey,
      ).router,
      theme: MainAppTheme(
        MainColors(),
        AppValuesMain(),
      ).mainTheme,
    );
  }
}
