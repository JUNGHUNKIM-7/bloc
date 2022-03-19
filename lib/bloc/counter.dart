import 'package:equatable/equatable.dart';
import 'package:flutter_application_1/bloc/base.dart';

enum CounterEvent { increment, decrement }

abstract class CounterBlocInterface {
  void dispose();
}

mixin CounterMixin<T> {}

class CounterBloc extends Equatable
    with CounterMixin
    implements CounterBlocInterface {
  final eventController = BaseStreamController<CounterEvent?>(state: null);
  final counterController = BaseStreamController<int>(state: 0);

  Stream<int> get counterStream => counterController.sub.stream;

  Stream<CounterEvent?> get eventStream => eventController.sub.stream;
  set eventSub(CounterEvent evt) => eventController.state = evt;

  CounterBloc() {
    eventController.sub.listen((CounterEvent? evt) {
      switch (evt) {
        case CounterEvent.increment:
          counterController.state += 1;
          break;
        case CounterEvent.decrement:
          counterController.state -= 1;
          break;
        default:
          counterController.sub.add(counterController.state);
      }
    });
  }

  @override
  void dispose() {
    counterController.dispose();
    eventController.dispose();
  }

  @override
  List<Object?> get props => [counterController.state];
}
