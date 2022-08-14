import 'dart:convert';

import 'package:com_ind_imariners/db/models/category_model.dart';
import 'package:com_ind_imariners/pirvacy_policy_page/privacy_policy_view.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../contact_us_page/contact_us_view.dart';
import '../db/api/auth_api.dart';
import '../db/api/category_api.dart';
import '../db/models/user_model.dart';
import '../login_page/login_provider.dart';
import '../theme/colors.dart';
import '../utill/font_size_hanlder.dart';
import 'snackbar_factory.dart';
import 'package:http/http.dart' as http;

class AppBarCurve extends StatefulWidget {
  final String text;
  final isContent;
  final VoidCallback openDrawer;

  const AppBarCurve(
      {Key? key,
      required this.text,
      required this.isContent,
      required this.openDrawer})
      : super(key: key);

  @override
  _AppBarCurveState createState() => _AppBarCurveState();
}

class _AppBarCurveState extends State<AppBarCurve> {
  @override
  Widget build(BuildContext context) {
    final double fontSize = MediaQuery.of(context).textScaleFactor;

    return Stack(
      children: [
        Container(
          height: MediaQuery.of(context).size.height * 0.3,
          child: Image(
            width: MediaQuery.of(context).size.width,
            fit: BoxFit.fill,
            image: widget.text != "Knowledge Base"
                ? const AssetImage("assets/app_bar_curve.png")
                : const AssetImage("assets/app_bar_back.png"),
          ),
        ),
        widget.text != "Login"
            ? widget.text != "Create Your Account"
                ? Positioned(
                    top: MediaQuery.of(context).size.height * -0.038,
                    left: MediaQuery.of(context).size.width * 0,
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.29,
                      child: SvgPicture.asset("assets/appbar_rec.svg"),
                    ),
                  )
                : Container()
            : Container(),
        widget.text != "Login"
            ? widget.text != "Create Your Account"
                ? Positioned(
                    top: MediaQuery.of(context).size.height * 0.055,
                    left: MediaQuery.of(context).size.width * 0.01,
                    child: InkWell(
                      onTap: () {
                        widget.openDrawer();
                      },
                      child: Container(
                          width: MediaQuery.of(context).size.width * 0.07,
                          child: Image.asset("assets/menu.png")),
                    ),
                  )
                : Container()
            : Container(),
        Positioned(
          top: widget.text != "Knowledge Base"
              ? MediaQuery.of(context).size.height * 0.15
              : MediaQuery.of(context).size.height * 0.11,
          right: MediaQuery.of(context).size.width * 0.04,
          child: Container(
            width: MediaQuery.of(context).size.width * 0.25,
            child: Image(
              width: MediaQuery.of(context).size.width,
              fit: BoxFit.fill,
              image: widget.text != "Knowledge Base"
                  ? const AssetImage("assets/ship_image.png")
                  : const AssetImage("assets/ship.png"),
            ),
          ),
        ),
        // widget.text == "Home"
        //     ? Positioned(
        //         top: MediaQuery.of(context).size.height * 0.25,
        //         left: MediaQuery.of(context).size.width * 0.06,
        //         child: Container(
        //           child: Icon(
        //             Icons.home,
        //             color: Colors.white,
        //             size: 25,
        //           ),
        //         ))
        //     : widget.text == "Knowledge Base"
        //         ? Positioned(
        //             top: MediaQuery.of(context).size.height * 0.248,
        //             left: MediaQuery.of(context).size.width * 0.065,
        //             child: Container(
        //               width: 25,
        //               child: Image.asset("assets/s.png"),
        //             ))
        //         : widget.text == "Telegram"
        //             ? Positioned(
        //                 top: MediaQuery.of(context).size.height * 0.248,
        //                 left: MediaQuery.of(context).size.width * 0.065,
        //                 child: Container(
        //                   width: 25,
        //                   child: Image.asset("assets/telegram.png"),
        //                 ))
        //             : widget.text == "Tools"
        //                 ? Positioned(
        //                     top: MediaQuery.of(context).size.height * 0.248,
        //                     left: MediaQuery.of(context).size.width * 0.065,
        //                     child: Container(
        //                       width: 25,
        //                       child: Image.asset("assets/t.png"),
        //                     ))
        //                 : Container(),
        Positioned(
          top: widget.isContent == true
              ? MediaQuery.of(context).size.height * 0.22
              : widget.text == "Login"
                  ? MediaQuery.of(context).size.height * 0.25
                  : widget.text == "Home"
                      ? MediaQuery.of(context).size.height * 0.25
                      : widget.text == "Knowledge Base"
                          ? MediaQuery.of(context).size.height * 0.25
                          : widget.text == "Telegram"
                              ? MediaQuery.of(context).size.height * 0.245
                              : widget.text == "Tools"
                                  ? MediaQuery.of(context).size.height * 0.245
                                  : MediaQuery.of(context).size.height * 0.22,
          left: widget.isContent == true
              ? MediaQuery.of(context).size.width * 0.08
              : widget.text == "Home"
                  ? MediaQuery.of(context).size.width * 0.13
                  : widget.text == "Knowledge Base"
                      ? MediaQuery.of(context).size.width * 0.15
                      : widget.text == "Telegram"
                          ? MediaQuery.of(context).size.width * 0.14
                          : widget.text == "Tools"
                              ? MediaQuery.of(context).size.width * 0.15
                              : MediaQuery.of(context).size.width * 0.10,
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.6,
            child: Text(
              widget.text == "Create Your Account"
                  ? "Create Your\nAccount"
                  : widget.text,
              overflow: TextOverflow.clip,
              style: GoogleFonts.roboto(
                fontSize: FontSizeHandle().getAppBarFontSizeMain(
                    fontSize, widget.text, widget.isContent),
                shadows: <Shadow>[
                  const Shadow(
                    offset: Offset(1.0, 1.0),
                    blurRadius: 3.0,
                    color: Color.fromARGB(255, 97, 95, 95),
                  ),
                ],
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
