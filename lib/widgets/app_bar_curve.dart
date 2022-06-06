import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class AppBarCurve extends StatefulWidget {
  final String text;
  final bool isContent;

  const AppBarCurve({Key? key, required this.text, required this.isContent})
      : super(key: key);

  @override
  _AppBarCurveState createState() => _AppBarCurveState();
}

class _AppBarCurveState extends State<AppBarCurve> {
  @override
  Widget build(BuildContext context) {
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
        Positioned(
          top: MediaQuery.of(context).size.height * -0.038,
          left: MediaQuery.of(context).size.width * 0,
          child: Container(
            width: MediaQuery.of(context).size.width * 0.29,
            child: SvgPicture.asset("assets/appbar_rec.svg"),
          ),
        ),
        Positioned(
          top: MediaQuery.of(context).size.height * 0.055,
          left: MediaQuery.of(context).size.width * 0.01,
          child: InkWell(
            onTap: () {},
            child: Container(
                width: MediaQuery.of(context).size.width * 0.07,
                child: Image.asset("assets/menu.png")),
          ),
        ),
        widget.isContent
            ? Positioned(
                top: MediaQuery.of(context).size.height * 0.25,
                right: MediaQuery.of(context).size.width * 0.18,
                child: InkWell(
                  onTap: () {},
                  child: Container(
                      width: MediaQuery.of(context).size.width * 0.07,
                      child: Image.asset("assets/below.png")),
                ),
              )
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
        widget.text == "Home"
            ? Positioned(
                top: MediaQuery.of(context).size.height * 0.25,
                left: MediaQuery.of(context).size.width * 0.06,
                child: Container(
                  child: Icon(
                    Icons.home,
                    color: Colors.white,
                    size: 25,
                  ),
                ))
            : widget.text == "Knowledge Base"
                ? Positioned(
                    top: MediaQuery.of(context).size.height * 0.248,
                    left: MediaQuery.of(context).size.width * 0.065,
                    child: Container(
                      width: 25,
                      child: Image.asset("assets/s.png"),
                    ))
                : widget.text == "Telegram"
                    ? Positioned(
                        top: MediaQuery.of(context).size.height * 0.248,
                        left: MediaQuery.of(context).size.width * 0.065,
                        child: Container(
                          width: 25,
                          child: Image.asset("assets/telegram.png"),
                        ))
                    : widget.text == "Tools"
                        ? Positioned(
                            top: MediaQuery.of(context).size.height * 0.248,
                            left: MediaQuery.of(context).size.width * 0.065,
                            child: Container(
                              width: 25,
                              child: Image.asset("assets/t.png"),
                            ))
                        : Container(),
        Positioned(
          top: widget.isContent == true
              ? MediaQuery.of(context).size.height * 0.25
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
                                  : MediaQuery.of(context).size.height * 0.23,
          left: widget.text == "Home"
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
              style: GoogleFonts.roboto(
                fontSize: widget.text == "Knowledge Base" ? 24 : 30,
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
