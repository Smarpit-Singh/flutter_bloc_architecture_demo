import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_architecture_demo/logic/cubit/counter_cubit.dart';
import 'package:flutter_bloc_architecture_demo/logic/cubit/settings_cubit.dart';
import 'package:flutter_bloc_architecture_demo/presentation/router/app_router.dart';

import 'logic/cubit/internet_cubit.dart';

void main() {
  runApp(MyApp(
    appRouter: AppRouter(),
    connectivity: Connectivity(),
  ));
}

class MyApp extends StatelessWidget {
  final AppRouter appRouter;
  final Connectivity connectivity;

  MyApp({
    Key key,
    @required this.appRouter,
    @required this.connectivity,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<InternetCubit>(create: (icContext) => InternetCubit(connectivity: connectivity)),
        BlocProvider<CounterCubit>(create: (ccContext) => CounterCubit()),
        BlocProvider<SettingsCubit>(create: (scContext) => SettingsCubit())
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        onGenerateRoute: appRouter.onGenerateRoute,
      ),
    );
  }
}
