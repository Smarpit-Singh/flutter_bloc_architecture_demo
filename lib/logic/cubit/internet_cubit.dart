import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_architecture_demo/constants/enum.dart';
import 'package:flutter_bloc_architecture_demo/logic/cubit/internet_state.dart';

class InternetCubit extends Cubit<InternetState> {
  final Connectivity connectivity;
  StreamSubscription connectivityStreamSubscription;

  /// Pass the initial state of Internet connection...
  InternetCubit({@required this.connectivity}) : super(InternetLoading()) {
    monitorInternetConnection();
  }

  /// This return StreamSubscription object of ConnectivityResult type when Internet state change...
  StreamSubscription<ConnectivityResult> monitorInternetConnection() {
    return connectivityStreamSubscription =
        connectivity.onConnectivityChanged.listen((result) {
      if (result == ConnectivityResult.wifi) {
        emitInternetConnected(ConnectionType.Wifi);
      } else if (result == ConnectivityResult.mobile) {
        emitInternetConnected(ConnectionType.Mobile);
      } else if (result == ConnectivityResult.none) {
        emitInternetDisconnected();
      }
    });
  }

  /// This emits InternetConnected state when either Mobile or Wifi connection get Connected...
  void emitInternetConnected(ConnectionType _type) =>
      emit(InternetConnected(type: _type));

  /// This emits InternetDisconnected state when internet get DisConnected...
  void emitInternetDisconnected() => emit(InternetDisconnected());

  /// Must cancel subscription of Connectivity Stream...
  @override
  Future<void> close() {
    connectivityStreamSubscription.cancel();
    return super.close();
  }
}
