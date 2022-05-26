/*
 * Copyright (c) FutureSoft 2021
 * Author: Daham
 *
 */

import 'package:flutter/cupertino.dart';

@immutable
class CounterState {
  final int count;

  CounterState({
    required this.count,
  });

  CounterState.init()
      : this(
          count: 0,
        );

  CounterState clone({
    int? count,
  }) {
    return CounterState(
      count: count ?? this.count,
    );
  }

  static CounterState get initialState => CounterState(
        count: 0,
      );
}
