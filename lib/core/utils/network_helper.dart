import 'package:find_the_words/features/stage/presentation/clickable_stage_bloc/clickable_stage_bloc.dart';
import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import './scaffold_message.dart';

class NetworkHelper {
  static void observeNetwork(
    GlobalKey<ScaffoldMessengerState> scaffoldKey,
    BuildContext context,
  ) {
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      if (result == ConnectivityResult.none) {
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
      } else {
        BlocProvider.of<ClickableStageBloc>(context)
            .add(const ChangeAbsorb(absorb: false));
        scaffoldKey.currentState?.hideCurrentSnackBar();
      }
    });
  }
}
