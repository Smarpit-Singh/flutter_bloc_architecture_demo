import 'package:flutter/material.dart';

class CounterState {
  int counterValue;
  bool wasIncremented;

  CounterState({
    @required this.counterValue,
    this.wasIncremented,
  });
}
