import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_architecture_demo/logic/cubit/settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  SettingsCubit()
      : super(SettingsState(
          appNotification: false,
          emailNotification: false,
        ));

  void toggleAppNotification(bool newVal) =>
      emit(state.copyWith(appNotification: newVal));

  void toggleEmailNotification(bool newVal) =>
      emit(state.copyWith(emailNotification: newVal));
}
