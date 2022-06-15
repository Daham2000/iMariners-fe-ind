import 'package:com_ind_imariners/db/models/user_model.dart';
import 'package:com_ind_imariners/home_page/home_provider.dart';
import 'package:com_ind_imariners/login_page/login_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../theme/colors.dart';
import '../../widgets/snackbar_factory.dart';
import '../counter_cubit.dart';

class RemindMeButton extends StatefulWidget {
  const RemindMeButton({Key? key}) : super(key: key);

  @override
  _RemindMeButtonState createState() => _RemindMeButtonState();
}

class _RemindMeButtonState extends State<RemindMeButton> {
  bool status = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(
            value: status,
            onChanged: (v) {
              setState(() {
                status = !status;
              });
            }),
        Text(
          "Reminder me",
          style:
              GoogleFonts.roboto(fontSize: 15, color: ThemeColors.TEXT_COLOR),
        )
      ],
    );
  }
}

class ActionButton extends StatefulWidget {
  String? text;
  String? code;
  String? email;
  String? username;
  String? password;
  String? rePassword;
  CounterCubit? bloc;
  final formKey;

  ActionButton(
      {Key? key,
      this.text,
      this.code,
      this.bloc,
      this.email,
      this.username,
      this.password,
      this.rePassword,
      this.formKey})
      : super(key: key);

  @override
  _ActionButtonState createState() => _ActionButtonState();
}

class _ActionButtonState extends State<ActionButton> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    final double fontSize = MediaQuery.of(context).textScaleFactor;
    return isLoading
        ? Center(
            child: CircularProgressIndicator(),
          )
        : SizedBox(
            width: MediaQuery.of(context).size.width * 0.7,
            child: ElevatedButton(
                onPressed: () async {
                  if (widget.text == "Change password") {
                    if (widget.password != widget.rePassword) {
                      print(widget.password);
                      print(widget.email);
                      ScaffoldMessenger.of(context)
                          .showSnackBar(SnackBarFactory().getSnackBar(
                        isFail: true,
                        title: "Password does not match",
                        fontSize: fontSize,
                      ));
                    } else {
                      if (widget.formKey.currentState.validate()) {
                        final result = await widget.bloc?.changePassword(
                            widget.email ?? "", widget.password ?? "");
                        if (result == 401) {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(SnackBarFactory().getSnackBar(
                            isFail: true,
                            title: "Change password unsuccessful",
                            fontSize: fontSize,
                          ));
                        }
                        if (result == 200) {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(SnackBarFactory().getSnackBar(
                            isFail: false,
                            title: "Change password successful",
                            fontSize: fontSize,
                          ));
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginProvider()),
                          );
                        }
                      }
                    }
                  } else {
                    if (widget.code != null) {
                      final result = await widget.bloc
                          ?.codeCheck(widget.email ?? "", widget.code ?? "");
                      if (result == 401) {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(SnackBarFactory().getSnackBar(
                          isFail: true,
                          title: "Incorrect Code",
                          fontSize: fontSize,
                        ));
                      }
                    } else {
                      if (widget.text == "Send code") {
                        await widget.bloc
                            ?.resetPasswordEmail(User(email: widget.email));
                      } else {
                        if (widget.formKey.currentState.validate()) {
                          if (widget.username == null) {
                            setState(() {
                              isLoading = true;
                            });
                            final int? result = await widget.bloc?.login(User(
                                email: widget.email,
                                password: widget.password));
                            setState(() {
                              isLoading = false;
                            });
                            if (result != null && result == 200) {
                              Future.microtask(() => Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => HomeProvider()),
                                  ));
                            } else {
                              if (result == 401) {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBarFactory().getSnackBar(
                                  isFail: true,
                                  title: "Incorrect Email or Password",
                                  fontSize: fontSize,
                                ));
                              }
                              if (result == 400) {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBarFactory().getSnackBar(
                                  isFail: true,
                                  title:
                                      "Another device is already logged in from this account",
                                  fontSize: fontSize,
                                ));
                              }
                            }
                          } else {
                            setState(() {
                              isLoading = true;
                            });
                            final int? result = await widget.bloc?.registerUser(
                                User(
                                    email: widget.email,
                                    password: widget.password,
                                    username: widget.username));
                            setState(() {
                              isLoading = false;
                            });
                            if (result == 201) {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LoginProvider()),
                              );
                            }
                          }
                        }
                      }
                    }
                  }
                },
                child: Text(
                  widget.text ?? "",
                  style: GoogleFonts.roboto(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                )),
          );
  }
}

class ForgotPassword extends StatelessWidget {
  final String text;

  const ForgotPassword({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Text(
        text,
        style: GoogleFonts.roboto(
            fontSize: 15.0,
            decoration: TextDecoration.underline,
            color: ThemeColors.FORGOT_PASSWORD),
      ),
    );
  }
}

class OrField extends StatelessWidget {
  const OrField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 45),
      child: Row(children: <Widget>[
        Expanded(
          child: Container(
              margin: const EdgeInsets.only(left: 10.0, right: 20.0),
              child: const Divider(
                color: ThemeColors.TEXT_COLOR,
                height: 36,
              )),
        ),
        Text(
          "or",
          style: GoogleFonts.roboto(
            color: ThemeColors.TEXT_COLOR,
            fontSize: 18,
          ),
        ),
        Expanded(
          child: Container(
              margin: const EdgeInsets.only(left: 20.0, right: 10.0),
              child: const Divider(
                color: ThemeColors.TEXT_COLOR,
                height: 36,
              )),
        ),
      ]),
    );
  }
}

class SocialButton extends StatelessWidget {
  final String path;

  const SocialButton({Key? key, required this.path}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        final result = await FacebookAuth.i.login(
            permissions: ["email", "public_profile", "user_friends"]
        );
        print(result.message);
        print(result.status);
        print(result.accessToken);
      },
      child: ClipOval(
        child: SizedBox(
          height: 40, // Image radius
          child: Image.asset(path, fit: BoxFit.contain),
        ),
      ),
    );
  }
}

class SignupText extends StatelessWidget {
  final bool isLogin;

  const SignupText({Key? key, required this.isLogin}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          isLogin ? "Don’t Have an Account ?  " : "Already have an account? ",
          style: GoogleFonts.roboto(
            fontSize: 15.0,
            color: ThemeColors.TEXT_COLOR_TWO,
          ),
        ),
        Text(
          isLogin ? "Sign up" : "Sign in",
          style: GoogleFonts.roboto(
            fontSize: 15.0,
            decoration: TextDecoration.underline,
            color: ThemeColors.BLUE_TEXT,
          ),
        )
      ],
    );
  }
}
