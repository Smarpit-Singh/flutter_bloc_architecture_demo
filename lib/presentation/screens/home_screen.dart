import 'dart:js';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_architecture_demo/constants/enum.dart';
import 'package:flutter_bloc_architecture_demo/logic/cubit/counter_cubit.dart';
import 'package:flutter_bloc_architecture_demo/logic/cubit/counter_state.dart';
import 'package:flutter_bloc_architecture_demo/logic/cubit/internet_cubit.dart';
import 'package:flutter_bloc_architecture_demo/logic/cubit/internet_state.dart';

class HomeScreen extends StatefulWidget {
  final String title;
  final Color color;

  HomeScreen({Key key, this.title, this.color}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<InternetCubit, InternetState>(
      listener: (cubitContext, state) {
        if (state is InternetConnected && state.type == ConnectionType.Wifi) {
          BlocProvider.of<CounterCubit>(context).increment();
        } else if (state is InternetConnected &&
            state.type == ConnectionType.Mobile) {
          BlocProvider.of<CounterCubit>(context).decrement();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: widget.color,
          title: Text(widget.title),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              BlocBuilder<InternetCubit, InternetState>(
                builder: (cubitContext, state) {
                  if (state is InternetConnected &&
                      state.type == ConnectionType.Wifi) {
                    return Text(
                      'Wi-Fi',
                      style: Theme.of(cubitContext)
                          .textTheme
                          .headline3
                          .copyWith(color: Colors.green),
                    );
                  } else if (state is InternetConnected &&
                      state.type == ConnectionType.Mobile) {
                    return Text(
                      'Mobile',
                      style: Theme.of(cubitContext)
                          .textTheme
                          .headline3
                          .copyWith(color: Colors.red),
                    );
                  } else if (state is InternetDisconnected) {
                    return Text(
                      'Disconnected',
                      style: Theme.of(cubitContext)
                          .textTheme
                          .headline3
                          .copyWith(color: Colors.grey),
                    );
                  }
                  return CircularProgressIndicator();
                },
              ),
              Divider(
                height: 5,
              ),
              BlocConsumer<CounterCubit, CounterState>(
                  builder: (counterCubitContext1, state1) {
                if (state1.counterValue < 0) {
                  return Text(
                    'BRR, NEGATIVE ' + state1.counterValue.toString(),
                    style: Theme.of(counterCubitContext1).textTheme.headline4,
                  );
                } else if (state1.counterValue % 2 == 0) {
                  return Text(
                    'YAAAY ' + state1.counterValue.toString(),
                    style: Theme.of(counterCubitContext1).textTheme.headline4,
                  );
                } else if (state1.counterValue == 5) {
                  return Text(
                    'HMM, NUMBER 5',
                    style: Theme.of(counterCubitContext1).textTheme.headline4,
                  );
                } else {
                  return Text(
                    state1.counterValue.toString(),
                    style: Theme.of(counterCubitContext1).textTheme.headline4,
                  );
                }
              }, listener: (counterCubitContext2, state2) {
                if (state2.wasIncremented == true) {
                  ScaffoldMessenger.of(counterCubitContext2).showSnackBar(
                    SnackBar(
                      content: Text('Incremented!'),
                      duration: Duration(milliseconds: 300),
                    ),
                  );
                } else if (state2.wasIncremented == false) {
                  ScaffoldMessenger.of(counterCubitContext2)
                      .showSnackBar(SnackBar(
                    content: Text('Decremented!'),
                    duration: Duration(milliseconds: 300),
                  ));
                }
              }),
              Builder(
                builder: (materialButtonContext) => MaterialButton(
                  color: Colors.redAccent,
                  child: Text(
                    'Go to Second Screen',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {
                    Navigator.of(materialButtonContext).pushNamed(
                      '/second',
                    );
                  },
                ),
              ),
              MaterialButton(
                color: Colors.greenAccent,
                child: Text(
                  'Go to Third Screen',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  Navigator.of(context).pushNamed(
                    '/third',
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
