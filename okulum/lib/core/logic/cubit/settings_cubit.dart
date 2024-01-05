import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:meta/meta.dart';

part 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> with HydratedMixin {
  SettingsCubit()
      : super(
          const SettingsState(),
        );

  void toggleAppNotifications(bool newValue) {
    emit(SettingsState(appNotifications: newValue));
  }

  void toggleEmailNotifications(bool newValue) =>
      emit(SettingsState(emailNotifications: newValue));

  @override
  SettingsState fromJson(Map<String, dynamic> json) {
    return SettingsState.fromMap(json);
  }

  @override
  Map<String, dynamic> toJson(SettingsState state) {
    return state.toMap();
  }
}
