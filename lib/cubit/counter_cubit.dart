import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'counter_state.dart';

class CounterCubit extends Cubit<CounterState> {
  CounterCubit() : super(CounterState(countValue: 0));

  void increment() => emit(CounterState(countValue: state.countValue+1, wasIncremented: true));
  void decrement() => emit(CounterState(countValue: state.countValue-1, wasIncremented: false));
}
