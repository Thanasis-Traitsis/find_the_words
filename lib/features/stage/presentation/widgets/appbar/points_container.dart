import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/constants/styles.dart';
import '../../../../../core/usecases/calculate_size.dart';
import '../../../../auth/presentation/auth_bloc/auth_bloc.dart';
import '../../../../auth/presentation/points_bloc/points_bloc.dart';

Widget PointsContainer({
  required BuildContext context,
}) {
  return Container(
    margin: const EdgeInsets.only(right: padding),
    padding: EdgeInsets.only(
      right: calculateSize(
        context,
        3,
      ),
      bottom: calculateSize(
        context,
        3,
      ),
    ),
    decoration: BoxDecoration(
      color: Theme.of(context).colorScheme.outline,
      borderRadius: BorderRadius.circular(
        borderRadius,
      ),
    ),
    child: Container(
      padding: EdgeInsets.all(
        calculateSize(
          context,
          padding / 2,
        ),
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primaryContainer,
        border: Border.all(
          color: Theme.of(context).colorScheme.outline,
          width: calculateSize(
            context,
            2,
          ),
        ),
        borderRadius: BorderRadius.circular(
          borderRadius,
        ),
      ),
      child: Row(
        children: [
          BlocBuilder<PointsBloc, PointsState>(
            builder: (context, state) {
              return Text(
                state.points.toString(),
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: calculateSize(
                    context,
                    Theme.of(context).textTheme.bodySmall!.fontSize!,
                  ),
                  color: Theme.of(context).colorScheme.surface,
                ),
              );
            },
          ),
          Icon(
            Icons.star_rounded,
            color: Theme.of(context).colorScheme.surface,
            size: calculateSize(
              context,
              Theme.of(context).primaryIconTheme.size! * .7,
            ),
          ),
        ],
      ),
    ),
  );
}
