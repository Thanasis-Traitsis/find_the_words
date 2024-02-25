import 'package:find_the_words/features/auth/data/repositories/auth_repositories_impl.dart';
import 'package:find_the_words/features/auth/presentation/widgets/end_drawer/alert_delete_account_dialog.dart';
import 'package:find_the_words/features/auth/presentation/widgets/end_drawer/alert_stage_dialog.dart';
import 'package:find_the_words/features/auth/presentation/widgets/end_drawer/drawer_section.dart';
import 'package:find_the_words/features/stage/presentation/sound_bloc/sound_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../../core/constants/styles.dart';
import '../../../../../core/usecases/calculate_size.dart';
import '../../version_bloc/version_bloc.dart';
import 'custom_drawer_header.dart';
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
                                function: () async {
                                  if (!await launchUrl(Uri.parse(
                                      'https://github.com/Thanasis-Traitsis/find_the_words/blob/main/privacy_policy.md'))) {
                                    throw Exception(
                                        'Could not launch privacy policye');
                                  }
                                },
                              ),
                              MenuItem(
                                context: context,
                                hasIcon: true,
                                text: 'Διαγραφή Λογαριασμού',
                                icon: FontAwesomeIcons.userXmark,
                                function: () {
                                  showDialog<void>(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDeleteAccountDialog(
                                          context: context);
                                    },
                                  );
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                      const Spacer(),
                      BlocBuilder<VersionBloc, VersionState>(
                        builder: (context, state) {
                          return Text(
                            'Version: ${state.version}',
                            style: TextStyle(
                              fontStyle: FontStyle.italic,
                              fontSize: calculateSize(
                                context,
                                Theme.of(context)
                                    .textTheme
                                    .bodySmall!
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
            );
          },
        ),
      ),
    ),
  );
}
