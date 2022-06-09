import 'package:com_ind_imariners/login_page/widgets/sample_widget.dart';
import 'package:com_ind_imariners/widgets/app_bar_curve.dart';
import 'package:com_ind_imariners/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../login_page/counter_cubit.dart';
import '../login_page/counter_state.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({Key? key}) : super(key: key);

  @override
  _CounterPageState createState() => _CounterPageState();
}

class _CounterPageState extends State<RegisterView> {
  final _formKey = GlobalKey<FormState>();

  final username = TextEditingController();
  final email = TextEditingController();
  final password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    CounterCubit counterCubit = BlocProvider.of<CounterCubit>(context);

    return Scaffold(
      body: BlocBuilder<CounterCubit, CounterState>(
        buildWhen: (pre, current) => pre.count != current.count,
        builder: (ctx, state) {
          return SingleChildScrollView(
            child: Column(
              children: [
                const AppBarCurve(
                  text: "Create Your Account",
                  isContent: false,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 40,
                        ),
                        CustomTextField(
                          text: "Username",
                          icon: Icon(Icons.person, color: Colors.grey[400]),
                          textEditingController: username,
                          obscureText: false,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        CustomTextField(
                            text: "Email Address",
                            icon: Icon(Icons.email, color: Colors.grey[400]),
                            textEditingController: email,
                            obscureText: false),
                        const SizedBox(
                          height: 20,
                        ),
                        CustomTextField(
                            text: "Password",
                            icon: Icon(Icons.lock, color: Colors.grey[400]),
                            textEditingController: password,
                            obscureText: true),
                        const SizedBox(
                          height: 10,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            ActionButton(
                              text: "Register",
                              email: email.text,
                              password: password.text,
                              username: username.text,
                              bloc: counterCubit,
                              formKey: _formKey,
                            ),
                          ],
                        ),
                        const OrField(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: const [
                            SocialButton(path: "assets/Google.jpg"),
                            SizedBox(
                              width: 15.0,
                            ),
                            SocialButton(path: "assets/facebook.png")
                          ],
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        const SignupText(
                          isLogin: false,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
