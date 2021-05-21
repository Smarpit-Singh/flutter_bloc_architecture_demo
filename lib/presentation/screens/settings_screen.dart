import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_architecture_demo/logic/cubit/settings_cubit.dart';
import 'package:flutter_bloc_architecture_demo/logic/cubit/settings_state.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey.shade700,
        title: Text('Settings'),
      ),
      body: BlocListener<SettingsCubit, SettingsState>(listener: (c, s) {
        final notificationSnackBar = SnackBar(
          duration: Duration(milliseconds: 700),
          content: Text(
            'App ' +
                s.appNotification.toString().toUpperCase() +
                ", Email " +
                s.emailNotification.toString().toUpperCase(),
          ),
        );
        ScaffoldMessenger.of(context).showSnackBar(notificationSnackBar);
      }, child: BlocBuilder<SettingsCubit, SettingsState>(
        builder: (c, s) {
          return Container(
            child: Column(
              children: [
                SwitchListTile(
                  value: s.appNotification!,
                  onChanged: (v) {
                    c.read<SettingsCubit>().toggleAppNotification(v);
                  },
                  title: Text('App Notification'),
                ),
                SwitchListTile(
                  value: s.emailNotification!,
                  onChanged: (v) {
                    c.read<SettingsCubit>().toggleEmailNotification(v);
                  },
                  title: Text('Email Notification'),
                )
              ],
            ),
          );
        },
      )),
    );
  }
}
