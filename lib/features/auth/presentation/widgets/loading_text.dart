import 'package:find_the_words/core/constants/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../connection_bloc/connection_bloc.dart';

Widget LoadingText() {
  return Padding(
    padding: const EdgeInsets.all(padding),
    child: BlocBuilder<ConnectivityBloc, ConnectivityState>(
      builder: (context, state) {
        return !state.hasConnection
            ? Text(
                'Δεν έχετε συνδεθεί στο διαδίκτυο. Συνδεθείτε για να ξεκινήσετε το παιχνίδι!',
                style: TextStyle(
                  fontSize: Theme.of(context).textTheme.bodySmall!.fontSize!,
                ),
                textAlign: TextAlign.center,
              )
            : Text(
                'Πραγματοποιείται η σύνδεση ...',
                style: TextStyle(
                  fontSize: Theme.of(context).textTheme.bodySmall!.fontSize!,
                ),
                textAlign: TextAlign.center,
              );
      },
    ),
  );
}
