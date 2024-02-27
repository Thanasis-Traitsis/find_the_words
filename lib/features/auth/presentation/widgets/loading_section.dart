import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/usecases/calculate_size.dart';
import '../auth_bloc/auth_bloc.dart';
import '../connection_bloc/connection_bloc.dart';

Widget LoadingSection({
  required BuildContext context,
}) {
  return BlocBuilder<ConnectivityBloc, ConnectivityState>(
    builder: (context, state) {
      return SizedBox(
        width: calculateSize(context, 80),
        height: calculateSize(context, 80),
        child: !state.hasConnection
            ? Image.asset(
                "assets/images/no_wifi_icon.png",
              )
            : Center(
                child: SizedBox(
                  width: calculateSize(context, 40),
                  height: calculateSize(context, 40),
                  child: const CircularProgressIndicator.adaptive(),
                ),
              ),
      );
    },
  );
}
