import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/styles.dart';
import '../../../../core/usecases/calculate_size.dart';
import '../../../../core/widgets/card_with_outline.dart';
import '../points_bloc/points_bloc.dart';
import 'card_text.dart';

Widget PinkHomeCard({
  required BuildContext context,
  bool isPorttrait = true,
}) {
  return CardWithOutline(
    context: context,
    color: Theme.of(context).colorScheme.primaryContainer,
    child: isPorttrait
        ? Column(
            children: [
              CardText(
                context: context,
                text: 'Συνολικοί',
                color: Theme.of(context).colorScheme.surface,
              ),
              CardText(
                context: context,
                text: 'Πόντοι',
                color: Theme.of(context).colorScheme.surface,
              ),
              const SizedBox(
                height: gap,
              ),
              Expanded(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minWidth: calculateSize(context, pinkCardInsideWith),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      color:
                          Theme.of(context).colorScheme.surface.withOpacity(.6),
                      borderRadius: BorderRadius.circular(
                        borderRadius,
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Theme.of(context).colorScheme.primaryContainer,
                              width: 2,
                            ),
                          ),
                          child: Center(
                            child: Icon(
                              Icons.star_rounded,
                              color: Theme.of(context)
                                  .colorScheme
                                  .primaryContainer,
                              size: calculateSize(
                                context,
                                Theme.of(context).primaryIconTheme.size!,
                              ),
                            ),
                          ),
                        ),
                        BlocBuilder<PointsBloc, PointsState>(
                          builder: (context, state) {
                            return Text(
                              state.points.toString(),
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context)
                                    .colorScheme
                                    .primaryContainer,
                                fontSize: calculateSize(
                                  context,
                                  Theme.of(context)
                                      .textTheme
                                      .headlineLarge!
                                      .fontSize!,
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          )
        : Row(
            children: [
              CardText(
                context: context,
                text: 'Πόντοι :',
                color: Theme.of(context).colorScheme.surface,
              ),
              Expanded(
                child: Row(
                  children: [
                    Expanded(
                      child: BlocBuilder<PointsBloc, PointsState>(
                        builder: (context, state) {
                          return Text(
                            state.points.toString(),
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).colorScheme.surface,
                              fontSize: calculateSize(
                                context,
                                Theme.of(context)
                                    .textTheme
                                    .headlineLarge!
                                    .fontSize!,
                              ),
                            ),
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.right,
                          );
                        },
                      ),
                    ),
                    Icon(
                      Icons.star_rounded,
                      color: Theme.of(context).colorScheme.surface,
                      size: calculateSize(
                        context,
                        Theme.of(context).primaryIconTheme.size!,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
  );
}
