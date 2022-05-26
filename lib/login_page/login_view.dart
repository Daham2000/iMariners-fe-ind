import 'package:com_ind_imariners/widgets/app_bar_curve.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'counter_cubit.dart';
import 'counter_state.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  _CounterPageState createState() => _CounterPageState();
}

class _CounterPageState extends State<LoginView> {
  @override
  Widget build(BuildContext context) {
    // CounterCubit counterCubit = BlocProvider.of<CounterCubit>(context);

    return Scaffold(
      body: BlocBuilder<CounterCubit, CounterState>(
        buildWhen: (pre, current) => pre.count != current.count,
        builder: (ctx, state) {
          return SingleChildScrollView(
            child: Column(
              children: [
                const AppBarCurve(),
                Container(
                  width: MediaQuery.of(context).size.width*0.7,
                  child: TextField(
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          // width: 0.0 produces a thin "hairline" border
                          borderSide: BorderSide(color: Colors.grey, width: 0.5),
                          borderRadius: BorderRadius.circular(50.0),
                        ),
                        filled: true,
                        hintStyle: TextStyle(color: Colors.grey[800]),
                        hintText: "Type in your text",
                        fillColor: Colors.white70),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
