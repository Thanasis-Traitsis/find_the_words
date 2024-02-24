import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/usecases/calculate_size.dart';
import '../../../stage/presentation/stage_bloc/stage_bloc.dart';

Widget CompleteButtonsContainer({
  required BuildContext context,
  required VoidCallback nextStage,
  required Function backToHome,
}) {
  return Column(
    children: [
      BlocBuilder<StageBloc, StageState>(
        builder: (context, state) {
          return Container(
            width: MediaQuery.of(context).size.width * .8,
            constraints: const BoxConstraints(
              minWidth: 450,
              maxWidth: 550,
            ),
            child: FilledButton(
              onPressed: nextStage,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: calculateSize(context, 30),
                    height: calculateSize(context, 30),
                  ),
                  Text(
                    'Επόμενο Στάδιο',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: calculateSize(
                        context,
                        Theme.of(context).textTheme.bodyLarge!.fontSize!,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: calculateSize(context, 30),
                    height: calculateSize(context, 30),
                    child: state is StageLoading
                        ? CircularProgressIndicator.adaptive(
                            backgroundColor:
                                Theme.of(context).colorScheme.surface,
                          )
                        : null,
                  ),
                ],
              ),
            ),
          );
        },
      ),
      TextButton(
        style: ButtonStyle(
          foregroundColor: MaterialStateProperty.all<Color>(
            Theme.of(context).colorScheme.outline,
          ),
        ),
        onPressed: () => backToHome(),
        child: Text(
          'Πίσω στην αρχική',
          style: TextStyle(
            fontSize: calculateSize(
              context,
              Theme.of(context).textTheme.bodyMedium!.fontSize!,
            ),
          ),
        ),
      ),
    ],
  );
}
