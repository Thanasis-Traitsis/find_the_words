import 'package:find_the_words/core/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/styles.dart';
import '../../../../core/usecases/calculate_size.dart';
import '../../../stage/presentation/stage_bloc/stage_bloc.dart';

Widget HomeButton({
  required BuildContext context,
  required VoidCallback function,
  required String stage,
}) {
  return Center(
    child: Stack(
      alignment: Alignment.center,
      children: [
        SizedBox(
          width: double.infinity,
          height: calculateSize(
            context,
            AppValuesMain().homeButtonSize,
          ),
        ),
        Positioned(
          bottom: calculateSize(context, 30),
          child: BlocBuilder<StageBloc, StageState>(
            builder: (context, state) {
              return FilledButton(
                style: ButtonStyle(
                  padding: MaterialStateProperty.all<EdgeInsets>(
                    const EdgeInsets.symmetric(
                        horizontal: padding * 1.5, vertical: padding * 2),
                  ),
                ),
                onPressed: function,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: calculateSize(context, 30),
                      height: calculateSize(context, 30),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: gap / 2),
                      child: Text(
                        'Επόμενο Στάδιο',
                        style: TextStyle(
                          fontSize: calculateSize(
                            context,
                            Theme.of(context).textTheme.bodyLarge!.fontSize!,
                          ),
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
                    )
                  ],
                ),
              );
            },
          ),
        ),
        Positioned(
          bottom: 0,
          child: Container(
            padding: const EdgeInsets.symmetric(
              vertical: padding / 2,
              horizontal: padding * 2,
            ),
            decoration: BoxDecoration(
              border: Border.all(
                color: Theme.of(context).colorScheme.outline,
                width: 2,
              ),
              borderRadius: BorderRadius.circular(
                borderRadius,
              ),
              color: Theme.of(context).colorScheme.surface,
            ),
            child: Text(
              'Στάδιο $stage',
              style: TextStyle(
                fontSize: calculateSize(
                  context,
                  Theme.of(context).textTheme.bodyMedium!.fontSize!,
                ),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}
