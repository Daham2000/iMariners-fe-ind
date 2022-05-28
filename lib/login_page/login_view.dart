import 'package:com_ind_imariners/login_page/widgets/sample_widget.dart';
import 'package:com_ind_imariners/theme/colors.dart';
import 'package:com_ind_imariners/widgets/app_bar_curve.dart';
import 'package:com_ind_imariners/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

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

    final username = TextEditingController();
    final password = TextEditingController();

    return Scaffold(
      body: BlocBuilder<CounterCubit, CounterState>(
        buildWhen: (pre, current) => pre.count != current.count,
        builder: (ctx, state) {
          return SingleChildScrollView(
            child: Column(
              children: [
                const AppBarCurve(
                  text: "Login",
                  isContent: false,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 40,
                      ),
                      CustomTextField(
                        text: "Username",
                        icon: Icon(Icons.person, color: Colors.grey[400]),
                        textEditingController: username,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      CustomTextField(
                        text: "Password",
                        icon: Icon(Icons.lock, color: Colors.grey[400]),
                        textEditingController: password,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const RemindMeButton(),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          const ActionButton(text: "Login"),
                          const SizedBox(
                            height: 2,
                          ),
                          ForgotPassword(),
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
                      const SignupText(),
                    ],
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
