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
  final _formKey = GlobalKey<FormState>();

  final username = TextEditingController();
  final password = TextEditingController();

  Widget getTextField({
    required TextEditingController ctrl,
    required bool obscureText,
    required Icon icon,
    required String text
  }) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.86,
      child: TextFormField(
        controller: ctrl,
        obscureText: obscureText,
        validator: (text) {
          if (text == null || text.isEmpty) {
            return "This field can't be empty";
          }
          return null;
        },
        decoration: InputDecoration(
            prefixIcon: icon,
            enabledBorder: OutlineInputBorder(
              // width: 0.0 produces a thin "hairline" border
              borderSide: const BorderSide(color: Colors.grey, width: 0.5),
              borderRadius: BorderRadius.circular(50.0),
            ),
            hintStyle: TextStyle(color: Colors.grey[400]),
            hintText: text,
            fillColor: Colors.white70),
      ),
    );
  }

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
                  text: "Login",
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
                        getTextField(
                          text: "Email",
                          icon: Icon(Icons.person, color: Colors.grey[400]),
                          ctrl: username,
                          obscureText: false,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        getTextField(
                          text: "Password",
                          icon: Icon(Icons.lock, color: Colors.grey[400]),
                          ctrl: password,
                          obscureText: true,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const RemindMeButton(),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            ActionButton(
                              text: "Login",
                              email: username.text,
                              password: password.text,
                              bloc: counterCubit,
                              formKey: _formKey,
                            ),
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
