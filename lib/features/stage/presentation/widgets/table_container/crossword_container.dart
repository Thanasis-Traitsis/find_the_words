import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../stage_bloc/stage_bloc.dart';

class CrosswordContainer extends StatelessWidget {
  const CrosswordContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StageBloc, StageState>(
      builder: (context, state) {
        return state is StageStarted
            ? Center(
                child: GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  padding: const EdgeInsets.all(10),
                  shrinkWrap: true,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: sqrt(state.tableList.length).ceil(),
                  ),
                  itemCount: state.tableList.length,
                  itemBuilder: (context, index) {
                    return state.tableList[index];
                  },
                ),
              )
            : const Center(
                child: CircularProgressIndicator.adaptive(),
              );
      },
    );
  }
}
