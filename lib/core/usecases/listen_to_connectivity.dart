import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../features/auth/presentation/connection_bloc/connection_bloc.dart';
void listenToConnectivity({
  required GlobalKey<ScaffoldMessengerState> scaffoldKey,
  required BuildContext context,
}) {
  Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
    BlocProvider.of<ConnectivityBloc>(context)
        .add(CheckConnection(hasConnection: result != ConnectivityResult.none));
  });
}