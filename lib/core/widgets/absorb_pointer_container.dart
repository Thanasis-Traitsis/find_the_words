import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../features/stage/presentation/clickable_stage_bloc/clickable_stage_bloc.dart';

Widget AbsorbPointerContainer({
  required BuildContext context,
  required Widget child,
}) {
  return BlocBuilder<ClickableStageBloc, ClickableStageState>(
    builder: (context, state) {
      return AbsorbPointer(
        absorbing: state.absorb,
        child: child,
      );
    },
  );
}
