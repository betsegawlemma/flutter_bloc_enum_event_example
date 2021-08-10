import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(MaterialApp(
    home: Scaffold(
      appBar: AppBar(
        title: Text("Bloc Demo"),
      ),
      body: BlocProvider(
        create: (_) => CounterBloc(),
        child: CounterWidget(),
      ),
    ),
  ));
}

class CounterWidget extends StatelessWidget {
  const CounterWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext ctx) {
    return Center(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            onPressed: () {
              BlocProvider.of<CounterBloc>(ctx).add(CounterEvent.decrement);
            },
            icon: Icon(Icons.remove),
          ),
          BlocBuilder<CounterBloc, int>(
            builder: (context, state) => Text("$state"),
          ),
          IconButton(
            onPressed: () {
              BlocProvider.of<CounterBloc>(ctx).add(CounterEvent.increment);
            },
            icon: Icon(Icons.add),
          ),
        ],
      ),
    );
  }
}

enum CounterEvent { increment, decrement }

class CounterBloc extends Bloc<CounterEvent, int> {
  CounterBloc() : super(0);

  Stream<int> mapEventToState(CounterEvent event) async* {
    switch (event) {
      case CounterEvent.increment:
        yield state + 1;
        break;
      case CounterEvent.decrement:
        yield state - 1;
    }
  }
}
