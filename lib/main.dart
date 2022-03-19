import 'package:flutter/material.dart';
import 'package:flutter_application_1/bloc/base.dart';
import 'package:flutter_application_1/bloc/counter.dart';

void main() {
  runApp(
    BlocProvider(
      child: const App(),
    ),
  );
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late final CounterBloc _counterBloc;

  @override
  void initState() {
    super.initState();
    _counterBloc = CounterBloc();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementcounter,
        child: const Icon(Icons.add),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("hello world"),
            StreamBuilder<int>(
              initialData: 0,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Text(
                    '${snapshot.data}',
                  );
                }
                return Container();
              },
              stream: _counterBloc.counterStream,
            ),
          ],
        ),
      ),
    );
  }

  void _incrementcounter() {
    _counterBloc.eventSub = CounterEvent.increment;
  }

  @override
  void dispose() {
    _counterBloc.dispose();
    super.dispose();
  }
}
