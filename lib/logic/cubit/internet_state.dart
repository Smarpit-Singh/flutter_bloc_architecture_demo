import 'package:flutter/material.dart';
import 'package:flutter_bloc_architecture_demo/constants/enum.dart';

@immutable
abstract class InternetState {} ///Base abstract class

class InternetLoading extends InternetState {} ///Loading state

class InternetConnected extends InternetState { ///Connected state
  final ConnectionType type;

  InternetConnected({
    required this.type,
  });
}

class InternetDisconnected extends InternetState {} ///Disconnected State
