import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class SettingsState extends Equatable {
  final bool? appNotification;
  final bool? emailNotification;

  SettingsState({
    required this.appNotification,
    required this.emailNotification,
  });

  SettingsState copyWith({bool? appNotification, bool? emailNotification}) {
    return SettingsState(
      appNotification: appNotification ?? this.appNotification,
      emailNotification: emailNotification ?? this.emailNotification,
    );
  }

  @override
  List<Object> get props => [
        appNotification!,
        emailNotification!,
      ];

  @override
  String toString() =>
      'SettingsState(appNotifications: $appNotification, emailNotifications: $emailNotification)';
}
