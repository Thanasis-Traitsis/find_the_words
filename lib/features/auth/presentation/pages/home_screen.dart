// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:find_the_words/features/auth/presentation/widgets/simple_icon_button.dart';

import '../../../../core/constants/styles.dart';
import '../../../../core/utils/breakpoints_utils.dart';
import '../../../../core/widgets/absorb_pointer_container.dart';
import '../../../stage/presentation/stage_bloc/stage_bloc.dart';
import '../../data/models/user_model.dart';
import '../../domain/usecases/get_current_stage_map.dart';
import '../../domain/usecases/get_instructions.dart';
import '../../domain/usecases/prepare_for_stage.dart';
import '../../domain/usecases/stage_created_successful.dart';
import '../widgets/blue_home_card.dart';
import '../widgets/earn_points/earn_points_button.dart';
import '../widgets/end_drawer/drawer_container.dart';
import '../widgets/green_home_card.dart';
import '../widgets/home_background.dart';
import '../widgets/home_button.dart';
import '../widgets/home_cards_container.dart';
import '../widgets/home_landscape_background.dart';
import '../widgets/home_landscape_container.dart';
import '../widgets/logo_container.dart';
import '../widgets/pink_home_card.dart';

class HomeScreen extends StatefulWidget {
  final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey;
  UserModel user;

  HomeScreen({
    Key? key,
    required this.scaffoldMessengerKey,
    required this.user,
  }) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  Map currentStage = {};
  Map inst = {};

  void initializeInstructions() async {
    Map details = await getInstructions();

    setState(() {
      inst = details;
    });
  }

  @override
  void initState() {
    initializeInstructions();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final deviceOrientation = getDeviceOrientation(context);

    onStageButtonPressed(List? bannedKeys, UserModel? user) {
      // Get current stage lists
      prepareForStage(
        context: context,
        user: user ?? widget.user,
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
            user: widget.user,
          );
        }

        if (state is StageFailedCreation) {
          onStageButtonPressed(state.bannedKeys, state.user);
        }
      },
      child: AbsorbPointerContainer(
        context: context,
        child: Scaffold(
          key: scaffoldKey,
          endDrawer: DrawerContainer(
            context: context,
            scaffoldKey: scaffoldKey,
            inst: inst,
          ),
          appBar: AppBar(
            leadingWidth: 100,
            leading: const EarnPointsButton(),
            actions: [
              SimpleIconButton(
                context: context,
                function: () => scaffoldKey.currentState!.openEndDrawer(),
                icon: FontAwesomeIcons.gear,
              ),
            ],
          ),
          body: deviceOrientation == DeviceOrientation.portrait
              ? HomeBackground(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      LogoContainer(
                        context: context,
                      ),
                      HomeCardsContainer(
                        context: context,
                        level: widget.user.level.toString(),
                      ),
                      HomeButton(
                        context: context,
                        function: () async {
                          currentStage = await getCurrentStageMap();

                          onStageButtonPressed(null, null);
                        },
                        stage: widget.user.stage.toString(),
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
                            level: widget.user.level.toString(),
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

                              onStageButtonPressed(null, null);
                            },
                            stage: widget.user.stage.toString(),
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
