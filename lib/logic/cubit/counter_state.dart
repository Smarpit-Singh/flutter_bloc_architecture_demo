import 'dart:convert';

import 'package:equatable/equatable.dart';

class CounterState extends Equatable {
  int? counterValue;
  bool? wasIncremented;

  CounterState({
    required this.counterValue,
    this.wasIncremented,
  }) {
    counterValue = 0;
    wasIncremented = true;
  }

  Map<String, dynamic> toMap() {
    return {
      'counterValue': counterValue,
      'wasIncremented': wasIncremented,
    };
  }

  factory CounterState.fromMap(Map<String, dynamic>? map) {
    return CounterState(
      counterValue: map!['counterValue'],
      wasIncremented: map['wasIncremented'],
    );
  }

  String toJson() => json.encode(toMap());

  factory CounterState.fromJson(String source) =>
      CounterState.fromMap(json.decode(source));

  @override
  List<Object> get props => [this.counterValue!, this.wasIncremented!];
}
