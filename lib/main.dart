import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'config/routes/routes.dart';
import 'config/theme/colors.dart';
import 'config/theme/theme.dart';
import 'core/constants/constants.dart';
import 'core/constants/sizes.dart';
import 'core/usecases/listen_to_connectivity.dart';
import 'core/utils/scaffold_message.dart';
import 'current_stage.dart';
import 'features/auth/data/repositories/auth_repositories_impl.dart';
import 'features/auth/presentation/auth_bloc/auth_bloc.dart';
import 'features/auth/presentation/connection_bloc/connection_bloc.dart';
import 'features/auth/presentation/earn_points_bloc/earn_points_bloc.dart';
import 'features/auth/presentation/points_bloc/points_bloc.dart';
import 'features/auth/presentation/version_bloc/version_bloc.dart';
import 'features/stage/data/repositories/answer_repositories_impl.dart';
import 'features/stage/data/repositories/stage_repositories_impl.dart';
import 'features/stage/presentation/answer_bloc/answer_bloc.dart';
import 'features/stage/presentation/clickable_stage_bloc/clickable_stage_bloc.dart';
import 'features/stage/presentation/crossword_table_bloc/crossword_table_bloc.dart';
import 'features/stage/presentation/letters_bloc/letters_bloc.dart';
import 'features/stage/presentation/letters_circle_bloc/letters_circle_bloc.dart';
import 'features/stage/presentation/sound_bloc/sound_bloc.dart';
import 'features/stage/presentation/stage_bloc/stage_bloc.dart';
import 'features/stage/presentation/stage_scroll_bloc/stage_scroll_bloc.dart';
import 'features/stage/presentation/stage_timer_bloc/stage_timer_bloc.dart';
import 'firebase_options.dart';

Future<void> main() async {
  await Hive.initFlutter();

  Hive.registerAdapter(CurrentStageAdapter());
  await Hive.openBox<CurrentStage>(currentStageBox);

  await dotenv.load();

  WidgetsFlutterBinding.ensureInitialized();
  unawaited(MobileAds.instance.initialize());

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
            return AuthBloc(
              authRepo: authRepositoriesImpl,
            )..add(
                AppStarted(),
              );
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
        BlocProvider<StageScrollBloc>(
          create: (context) {
            return StageScrollBloc();
          },
        ),
        BlocProvider<CrosswordTableBloc>(
          create: (context) {
            return CrosswordTableBloc();
          },
        ),
        BlocProvider<PointsBloc>(
          create: (context) {
            return PointsBloc()..add(GetPoints());
          },
        ),
        BlocProvider<LettersCircleBloc>(
          create: (context) {
            return LettersCircleBloc();
          },
        ),
        BlocProvider<ClickableStageBloc>(
          create: (context) {
            return ClickableStageBloc();
          },
        ),
        BlocProvider<StageTimerBloc>(
          create: (context) {
            return StageTimerBloc();
          },
        ),
        BlocProvider<AnswerBloc>(
          create: (context) {
            return AnswerBloc(answerRepo: answerRepositoriesImpl);
          },
        ),
        BlocProvider<SoundBloc>(
          create: (context) {
            return SoundBloc();
          },
        ),
        BlocProvider<ConnectivityBloc>(
          create: (context) {
            return ConnectivityBloc();
          },
        ),
        BlocProvider<EarnPointsBloc>(
          create: (context) {
            return EarnPointsBloc();
          },
        ),
        BlocProvider<VersionBloc>(
          create: (context) {
            return VersionBloc()..add(GetVersion());
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

    listenToConnectivity(scaffoldKey: scaffoldKey, context: context);

    return BlocListener<ConnectivityBloc, ConnectivityState>(
      listener: (context, state) {
        if (state.hasConnection) {
          BlocProvider.of<ClickableStageBloc>(context)
              .add(const ChangeAbsorb(absorb: false));
          scaffoldKey.currentState?.hideCurrentSnackBar();
        } else {
          BlocProvider.of<ClickableStageBloc>(context)
              .add(const ChangeAbsorb(absorb: true));

          scaffoldKey.currentState?.showSnackBar(
            ScaffoldMessage(
              context: context,
              message: 'Δε βρέθηκε σύνδεση. Παρακαλώ συνδεθείτε στο διαδίκτυο.',
              noError: false,
              onTap: () {
                BlocProvider.of<ClickableStageBloc>(context)
                    .add(const ChangeAbsorb(absorb: false));
                scaffoldKey.currentState?.hideCurrentSnackBar();
              },
            ),
          );
        }
      },
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        scaffoldMessengerKey: scaffoldKey,
        title: 'Βρες τις Λέξεις',
        routerConfig: AppRouter(
          scaffoldMessengerKey: scaffoldKey,
          rootNavigatorKey: navigatorKey,
        ).router,
        theme: MainAppTheme(
          MainColors(),
          AppValuesMain(),
        ).mainTheme,
      ),
    );
  }
}
