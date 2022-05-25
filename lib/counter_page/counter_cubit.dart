import 'package:flutter_bloc/flutter_bloc.dart';

import 'counter_state.dart';
import 'super_cubit.dart';

class CounterCubit extends Cubit<CounterState> implements SuperCubit {
  CounterCubit() : super(CounterState.init());

  @override
  void increment(int count) {
    emit(state.clone(count: state.count + 1));
  }

  @override
  void decrement() => emit(state.clone(count: state.count - 1));
}
