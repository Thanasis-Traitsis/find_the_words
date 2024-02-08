import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/styles.dart';
import '../../../../core/utils/breakpoints_utils.dart';
import '../../../../core/widgets/absorb_pointer_container.dart';
import '../../../stage/presentation/stage_bloc/stage_bloc.dart';
import '../../data/models/user_model.dart';
import '../../domain/usecases/get_current_stage_map.dart';
import '../../domain/usecases/prepare_for_stage.dart';
import '../../domain/usecases/stage_created_successful.dart';
import '../widgets/blue_home_card.dart';
import '../widgets/green_home_card.dart';
import '../widgets/home_background.dart';
import '../widgets/home_button.dart';
import '../widgets/home_cards_container.dart';
import '../widgets/home_landscape_background.dart';
import '../widgets/home_landscape_container.dart';
import '../widgets/logo_container.dart';
import '../widgets/pink_home_card.dart';

class HomeScreen extends StatelessWidget {
  final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey;
  UserModel user;

  HomeScreen({
    Key? key,
    required this.user,
    required this.scaffoldMessengerKey,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final deviceOrientation = getDeviceOrientation(context);

    Map currentStage = {};

    onStageButtonPressed(List? bannedKeys) {
      // Get current stage lists
      prepareForStage(
        context: context,
        user: user,
        current: currentStage,
        banned: bannedKeys,
      );
    }

    return BlocListener<StageBloc, StageState>(
      listener: (context, state) {
        if (state is StageStarted) {
          stageCreatedSuccessful(
            context: context,
            currentStage: currentStage,
            state: state,
            user: user,
          );
        }

        if (state is StageFailedCreation) {
          onStageButtonPressed(state.bannedKeys);
        }
      },
      child: AbsorbPointerContainer(
        context: context,
        child: Scaffold(
          body: deviceOrientation == DeviceOrientation.portrait
              ? HomeBackground(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      LogoContainer(
                        context: context,
                      ),
                      HomeCardsContainer(
                        context: context,
                        level: user.level.toString(),
                      ),
                      HomeButton(
                        context: context,
                        function: () async {
                          currentStage = await getCurrentStageMap();

                          onStageButtonPressed(null);
                        },
                        stage: user.stage.toString(),
                      ),
                    ],
                  ),
                )
              : HomeLandscapeBackground(
                  children: [
                    HomeLandscapeContainer(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          PinkHomeCard(
                            context: context,
                            isPorttrait: false,
                          ),
                          const SizedBox(
                            height: gap / 2,
                          ),
                          BlueHomeCard(
                            isPorttrait: false,
                          ),
                          const SizedBox(
                            height: gap / 2,
                          ),
                          GreenHomeCard(
                            context: context,
                            level: user.level.toString(),
                          ),
                        ],
                      ),
                    ),
                    HomeLandscapeContainer(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          LogoContainer(context: context),
                          HomeButton(
                            context: context,
                            function: () async {
                              currentStage = await getCurrentStageMap();

                              onStageButtonPressed(null);
                            },
                            stage: user.stage.toString(),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
