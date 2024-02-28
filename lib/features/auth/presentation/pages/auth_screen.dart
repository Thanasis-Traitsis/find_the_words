import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/styles.dart';
import '../auth_bloc/auth_bloc.dart';
import '../connection_bloc/connection_bloc.dart';
import '../widgets/loading_section.dart';
import '../widgets/loading_text.dart';
import '../widgets/logo_container.dart';
import 'home_screen.dart';

class AuthScreen extends StatelessWidget {
  final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey;

  AuthScreen({
    Key? key,
    required this.scaffoldMessengerKey,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool firstTry = true;
    bool connected = false;
    bool isAuth = false;

    return BlocBuilder<ConnectivityBloc, ConnectivityState>(
      builder: (context, state) {
        if (state.hasConnection) {
          connected = true;
        }

        if (state.hasConnection && !firstTry) {
          if (!isAuth) {
            BlocProvider.of<AuthBloc>(context).add(AppStarted());
          }
        }

        return Material(
          child: BlocBuilder<AuthBloc, AuthState>(
            builder: (context, state) {
              if (state is AuthAuthenticated) {
                isAuth = true;
              }
              if (state is AuthAuthenticated && connected) {
                firstTry = false;
                return HomeScreen(
                  user: state.user,
                  scaffoldMessengerKey: scaffoldMessengerKey,
                );
              }
              return Scaffold(
                body: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      LogoContainer(
                        context: context,
                      ),
                      const SizedBox(
                        height: gap * 2,
                      ),
                      LoadingSection(
                        context: context,
                      ),
                      const SizedBox(
                        height: gap * 2,
                      ),
                      LoadingText(),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
