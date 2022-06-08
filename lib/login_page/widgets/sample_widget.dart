import 'package:com_ind_imariners/db/models/user_model.dart';
import 'package:com_ind_imariners/home_page/home_page_view.dart';
import 'package:com_ind_imariners/home_page/home_provider.dart';
import 'package:com_ind_imariners/login_page/login_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../theme/colors.dart';
import '../../widgets/snackbar_factory.dart';
import '../counter_cubit.dart';

class RemindMeButton extends StatelessWidget {
  const RemindMeButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(value: false, onChanged: (v) {}),
        Text(
          "Reminder me",
          style:
              GoogleFonts.roboto(fontSize: 15, color: ThemeColors.TEXT_COLOR),
        )
      ],
    );
  }
}

class ActionButton extends StatelessWidget {
  String? text;
  String? email;
  String? username;
  String? password;
  CounterCubit? bloc;
  final formKey;

  ActionButton(
      {Key? key,
      this.text,
      this.bloc,
      this.email,
      this.username,
      this.password,
      this.formKey})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double fontSize = MediaQuery.of(context).textScaleFactor;

    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.7,
      child: ElevatedButton(
          onPressed: () async {
            if (formKey.currentState.validate()) {
              if (username == null) {
                final int? result =
                    await bloc?.login(User(email: email, password: password));
                if (result != null && result == 200) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => HomeProvider()),
                  );
                } else {
                  if (result == 400) {
                    ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBarFactory().getSnackBar(
                      isFail: true,
                      title: "Incorrect Email or Password",
                      fontSize: fontSize,
                    ));
                  }
                }
              } else {
                final bool? result = await bloc?.registerUser(
                    User(email: email, password: password, username: username));
                if (result != null && result == true) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginProvider()),
                  );
                }
              }
            }
          },
          child: Text(
            text ?? "",
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
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: InkWell(
        onTap: () {},
        child: Text(
          "Forgot password",
          style: GoogleFonts.roboto(
              fontSize: 15.0,
              decoration: TextDecoration.underline,
              color: ThemeColors.FORGOT_PASSWORD),
        ),
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
      onTap: () {},
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
  const SignupText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Don’t Have an Account ?  ",
          style: GoogleFonts.roboto(
            fontSize: 15.0,
            color: ThemeColors.TEXT_COLOR_TWO,
          ),
        ),
        Text(
          "Sign Up",
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
