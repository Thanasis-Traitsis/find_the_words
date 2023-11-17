import 'dart:convert';

import 'package:find_the_words/features/stage/presentation/stage_bloc/stage_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/utils/routes_utils.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    onStageButtonPressed() async {
      var jsonFile =
          await rootBundle.loadString('assets/lists/four_letters_list.json');

      List wordsList = jsonDecode(jsonFile)['four_letters'];

      BlocProvider.of<StageBloc>(context).add(
        StageButtonPressed(stageList: wordsList[7]),
      );
    }

    return BlocListener<StageBloc, StageState>(
      listener: (context, state) {
        if (state is StageStarted) {
          context.go(PAGES.stage.screenPath);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Home Screen'),
        ),
        body: Center(
          child: ElevatedButton(
            onPressed: () => onStageButtonPressed(),
            child: const Text(
              'Go to stage',
            ),
          ),
        ),
      ),
    );
  }
}
