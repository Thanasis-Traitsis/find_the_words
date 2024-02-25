import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:package_info_plus/package_info_plus.dart';

part 'version_event.dart';
part 'version_state.dart';

class VersionBloc extends Bloc<VersionEvent, VersionState> {
  VersionBloc() : super(const VersionState()) {
    on<GetVersion>(_onGetVersion);
  }

  void _onGetVersion(GetVersion event, Emitter<VersionState> emit) async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();

    String buildNumber = packageInfo.buildNumber;
    String version = packageInfo.version;

    emit(state.copyWith(version: Platform.isIOS ? buildNumber : version));
  }
}
