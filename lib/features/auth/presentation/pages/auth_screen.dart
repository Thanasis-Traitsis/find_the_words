import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/styles.dart';
import '../../../../core/usecases/listen_to_connectivity.dart';
import '../../../stage/presentation/clickable_stage_bloc/clickable_stage_bloc.dart';
import '../auth_bloc/auth_bloc.dart';
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
    listenToConnectivity(
      scaffoldKey: scaffoldMessengerKey,
      context: context,
    );
    return Material(
      child: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthNoConnection) {
            BlocProvider.of<ClickableStageBloc>(context)
                .add(const ChangeAbsorb(absorb: true));
          }
        },
        builder: (context, state) {
          if (state is AuthAuthenticated) {
            return HomeScreen(
              user: state.user,
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
                    state: state,
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
  }
}
