import 'package:com_ind_imariners/login_page/widgets/sample_widget.dart';
import 'package:com_ind_imariners/utill/shared_memory.dart';
import 'package:com_ind_imariners/widgets/app_bar_curve.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../home_page/home_provider.dart';
import '../register_page/register_provider.dart';
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
  final rePassword = TextEditingController();
  final code = TextEditingController();
  bool isLoading = false;

  @override
  void initState() {
    // getDetails();
    super.initState();
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
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  Future<void> getDetails() async {
    setState(() {
      isLoading = true;
    });
    final emailUser = await SharedMemory().getUserDetails("user");
    if (emailUser != null) {
      Future.microtask(() => Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => HomeProvider()),
          ));
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    CounterCubit counterCubit = BlocProvider.of<CounterCubit>(context);

    return Scaffold(
      body: BlocBuilder<CounterCubit, CounterState>(
        buildWhen: (pre, current) =>
            pre.isPasswordReset != current.isPasswordReset ||
            pre.isCodeValid != current.isCodeValid ||
            pre.emailSend != current.emailSend,
        builder: (ctx, state) {
          return SingleChildScrollView(
            child: Column(
              children: [
                const AppBarCurve(
                  text: "Login",
                  isContent: false,
                ),
                isLoading
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 40,
                              ),
                              state.emailSend == false
                                  ? state.isCodeValid == false ? getTextField(
                                      text: "Email",
                                      icon: Icon(Icons.person,
                                          color: Colors.grey[400]),
                                      ctrl: username,
                                      obscureText: false,
                                    ) : Container()
                                  : Container(),
                              const SizedBox(
                                height: 20,
                              ),
                              state.isPasswordReset == false
                                  ? Column(
                                      children: [
                                        getTextField(
                                          text: "Password",
                                          icon: Icon(Icons.lock,
                                              color: Colors.grey[400]),
                                          ctrl: password,
                                          obscureText: true,
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        const RemindMeButton(),
                                      ],
                                    )
                                  : state.emailSend == true
                                      ? Column(
                                          children: [
                                            getTextField(
                                              text: "Enter Code in the email",
                                              icon: Icon(Icons.person,
                                                  color: Colors.grey[400]),
                                              ctrl: code,
                                              obscureText: false,
                                            ),
                                            SizedBox(
                                              height: 10,
                                            )
                                          ],
                                        )
                                      : state.isCodeValid == true
                                          ? Column(
                                              children: [
                                                getTextField(
                                                  text: "Password",
                                                  icon: Icon(Icons.person,
                                                      color: Colors.grey[400]),
                                                  ctrl: password,
                                                  obscureText: false,
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                getTextField(
                                                  text: "Password Confirm",
                                                  icon: Icon(Icons.person,
                                                      color: Colors.grey[400]),
                                                  ctrl: rePassword,
                                                  obscureText: false,
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                )
                                              ],
                                            )
                                          : Container(),
                              state.isPasswordReset == false
                                  ? Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
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
                                        InkWell(
                                          onTap: () async {
                                            counterCubit.setResetPassword();
                                          },
                                          child: ForgotPassword(),
                                        ),
                                      ],
                                    )
                                  : state.emailSend == true
                                      ? ActionButton(
                                          text: "Validate the code",
                                          code: code.text,
                                          email: username.text,
                                          formKey: _formKey,
                                          bloc: counterCubit,
                                        )
                                      : state.isCodeValid == true
                                          ? ActionButton(
                                              text: "Change password",
                                              password: password.text,
                                              email: username.text,
                                              rePassword: rePassword.text,
                                              formKey: _formKey,
                                              bloc: counterCubit,
                                            )
                                          : ActionButton(
                                              text: "Send code",
                                              email: username.text,
                                              formKey: _formKey,
                                              bloc: counterCubit,
                                            ),
                              state.isPasswordReset == false
                                  ? Column(
                                      children: [
                                        const OrField(),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: const [
                                            SocialButton(
                                                path: "assets/Google.jpg"),
                                            SizedBox(
                                              width: 15.0,
                                            ),
                                            SocialButton(
                                                path: "assets/facebook.png")
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 15,
                                        ),
                                        InkWell(
                                          onTap: () {
                                            Future.microtask(
                                                () => Navigator.pushReplacement(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              RegisterProvider()),
                                                    ));
                                          },
                                          child: const SignupText(
                                            isLogin: true,
                                          ),
                                        ),
                                      ],
                                    )
                                  : Container(),
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
