import 'package:com_ind_imariners/login_page/login_provider.dart';
import 'package:com_ind_imariners/login_page/widgets/sample_widget.dart';
import 'package:com_ind_imariners/widgets/app_bar_curve.dart';
import 'package:com_ind_imariners/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../login_page/counter_cubit.dart';
import '../login_page/counter_state.dart';
import '../theme/colors.dart';

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
  final GlobalKey<ScaffoldState> _key = GlobalKey(); // Create a key
  bool passwordObscureText = true;

  void openDrawer() {
    _key.currentState!.openDrawer();
  }

  void hidePassword() {
    setState(() {
      passwordObscureText = !passwordObscureText;
    });
  }

  Widget getTextField(
      {required TextEditingController ctrl,
      required bool obscureText,
      required Icon icon,
      required String text}) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.86,
      child: TextFormField(
        controller: ctrl,
        obscureText: text == "Password" ? passwordObscureText : obscureText,
        validator: (text) {
          if (text == null || text.isEmpty) {
            return "This field can't be empty";
          }
          return null;
        },
        decoration: InputDecoration(
            prefixIcon: icon,
            suffixIcon: text == "Password"
                ? InkWell(
                    onTap: () {
                      hidePassword();
                    },
                    child: Icon(Icons.remove_red_eye),
                  )
                : Container(
                    width: 10,
                  ),
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
      key: _key,
      backgroundColor: ThemeColors.BACKGROUD_COLOR,
      body: BlocBuilder<CounterCubit, CounterState>(
        buildWhen: (pre, current) => pre.count != current.count,
        builder: (ctx, state) {
          return SingleChildScrollView(
            child: Column(
              children: [
                AppBarCurve(
                  text: "Create Your Account",
                  isContent: false,
                  openDrawer: openDrawer,
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
                          text: "Username",
                          icon: Icon(Icons.person, color: Colors.grey[400]),
                          ctrl: username,
                          obscureText: false,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        getTextField(
                          text: "Email Address",
                          icon: Icon(Icons.email, color: Colors.grey[400]),
                          ctrl: email,
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
                          children: [
                            SocialButton(
                              path: "assets/Google.jpg",
                              bloc: counterCubit,
                            ),
                            SizedBox(
                              width: 15.0,
                            ),
                            SocialButton(
                              path: "assets/facebook.png",
                              bloc: counterCubit,
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        InkWell(
                          onTap: () {
                            Future.microtask(() => Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => LoginProvider()),
                                ));
                          },
                          child: SignupText(
                            isLogin: false,
                          ),
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
