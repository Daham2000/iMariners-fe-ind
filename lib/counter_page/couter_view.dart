import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'counter_cubit.dart';
import 'counter_state.dart';

class CounterPage extends StatefulWidget {
  const CounterPage({Key? key}) : super(key: key);

  @override
  _CounterPageState createState() => _CounterPageState();
}

class _CounterPageState extends State<CounterPage> {
  @override
  Widget build(BuildContext context) {
    CounterCubit counterCubit = BlocProvider.of<CounterCubit>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Cubit Counter')),
      body: BlocBuilder<CounterCubit, CounterState>(
        buildWhen: (pre, current) => pre.count != current.count,
        builder: (ctx, state) {
          return Column(
            children: [
              Center(
                child: Text(
                  state.count.toString(),
                  style: const TextStyle(
                    fontSize: 25.0,
                    color: Colors.black,
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12.0),
                    child: FloatingActionButton(
                      child: const Icon(Icons.add),
                      onPressed: () {
                        counterCubit.increment(1);
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4.0),
                    child: FloatingActionButton(
                      child: const Icon(Icons.remove),
                      onPressed: () {
                        counterCubit.decrement();
                      },
                    ),
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}
