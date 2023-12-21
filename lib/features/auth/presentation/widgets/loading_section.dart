import 'package:flutter/material.dart';

import '../../../../core/usecases/calculate_size.dart';
import '../auth_bloc/auth_bloc.dart';

Widget LoadingSection({
  required BuildContext context,
  required AuthState state,
}) {
  return SizedBox(
    width: calculateSize(context, 80),
    height: calculateSize(context, 80),
    child: state is AuthNoConnection
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
}
