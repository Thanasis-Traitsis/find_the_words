import 'package:find_the_words/features/auth/presentation/auth_bloc/auth_bloc.dart';
import 'package:find_the_words/features/stage/presentation/stage_bloc/stage_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'config/routes/routes.dart';
import 'features/auth/data/repositories/auth_repositories_impl.dart';
import 'features/stage/data/repositories/stage_repositories_impl.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  final authRepositoriesImpl = AuthRepositoriesImpl();
  final stageRepositoriesImpl = StageRepositoriesImpl();

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
    );
  }
}
