import 'package:find_the_words/features/auth/presentation/widgets/end_drawer/alert_stage_dialog.dart';
import 'package:find_the_words/features/auth/presentation/widgets/end_drawer/drawer_section.dart';
import 'package:find_the_words/features/stage/presentation/sound_bloc/sound_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hive/hive.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../core/constants/constants.dart';
import '../../../../../core/constants/styles.dart';
import '../../../../../core/usecases/calculate_size.dart';
import '../../../../../current_stage.dart';
import 'custom_drawer_header.dart';
import 'drawer_section_header.dart';
import 'menu_item.dart';

Widget DrawerContainer({
  required BuildContext context,
  required GlobalKey<ScaffoldState> scaffoldKey,
  required Map inst,
}) {
  return Drawer(
    backgroundColor: Theme.of(context).colorScheme.background,
    child: SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(padding),
        child: LayoutBuilder(
          builder: (context, constraint) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraint.maxHeight),
                child: IntrinsicHeight(
                  child: Column(
                    children: [
                      CustomDrawerHeader(
                        context: context,
                        key: scaffoldKey,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          DrawerSection(
                            context: context,
                            header: inst['header'],
                            widgets: [
                              Text(
                                inst['text'],
                                style: TextStyle(
                                  fontSize: calculateSize(
                                    context,
                                    Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .fontSize!,
                                  ),
                                  color: Theme.of(context).colorScheme.outline,
                                ),
                              ),
                            ],
                          ),
                          DrawerSection(
                            context: context,
                            header: 'Στάδιο',
                            widgets: [
                              BlocBuilder<SoundBloc, SoundState>(
                                builder: (context, state) {
                                  return MenuItem(
                                    context: context,
                                    hasIcon: true,
                                    text: 'Ήχος',
                                    icon: state.hasSound
                                        ? FontAwesomeIcons.volumeHigh
                                        : FontAwesomeIcons.volumeXmark,
                                    function: () {
                                      BlocProvider.of<SoundBloc>(context)
                                          .add(ChangeSound());
                                    },
                                  );
                                },
                              ),
                              MenuItem(
                                context: context,
                                hasIcon: false,
                                text: 'Διαγραφή Σταδίου',
                                icon: null,
                                function: () async {
                                  showDialog<void>(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertStageDialog(context: context);
                                    },
                                  );
                                },
                              ),
                            ],
                          ),
                          DrawerSection(
                            context: context,
                            header: 'Λογαριασμός',
                            widgets: [
                              MenuItem(
                                context: context,
                                hasIcon: true,
                                text: 'Πολιτική Απορρίτου',
                                icon: FontAwesomeIcons.shieldHalved,
                                function: () {},
                              ),
                              MenuItem(
                                context: context,
                                hasIcon: true,
                                text: 'Διαγραφή Λογαριασμού',
                                icon: FontAwesomeIcons.userXmark,
                                function: () {},
                              ),
                            ],
                          ),
                        ],
                      ),
                      const Spacer(),
                      Text(
                        'Version: 1.0.1',
                        style: TextStyle(
                          fontStyle: FontStyle.italic,
                          fontSize: calculateSize(
                            context,
                            Theme.of(context).textTheme.bodySmall!.fontSize!,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    ),
  );
}
