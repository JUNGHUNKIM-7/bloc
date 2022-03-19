import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

abstract class BaseInterface {
  void dispose();
}

class BaseStreamController<T> implements BaseInterface {
  T _state;
  late final BehaviorSubject<T> _behaviorSubject;

  BaseStreamController({required T state}) : _state = state {
    _behaviorSubject = BehaviorSubject<T>.seeded(_state);
  }

  T get state => _state;
  set state(T value) {
    _state = value;
    _behaviorSubject.add(_state);
  }

  BehaviorSubject<T> get sub => _behaviorSubject;

  @override
  void dispose() {
    _behaviorSubject.close();
  }
}

class BlocProvider<T> extends InheritedWidget {
  const BlocProvider({Key? key, T? combiner, required Widget child})
      : _combiner = combiner,
        super(key: key, child: child);

  final T? _combiner;

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return true;
  }

  static U? of<U>(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<BlocProvider<U>>()!
        ._combiner;
  }
}
