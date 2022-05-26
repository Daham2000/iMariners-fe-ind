import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppBarCurve extends StatefulWidget {
  final String text;
  const AppBarCurve({Key? key, required this.text}) : super(key: key);

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
            image: const AssetImage("assets/app_bar_curve.png"),
          ),
        ),
        Positioned(
          top: MediaQuery.of(context).size.height * 0.15,
          right: MediaQuery.of(context).size.width * 0.04,
          child: Container(
            width: MediaQuery.of(context).size.width * 0.25,
            child: Image(
              width: MediaQuery.of(context).size.width,
              fit: BoxFit.fill,
              image: const AssetImage("assets/ship_image.png"),
            ),
          ),
        ),
        Positioned(
          top: MediaQuery.of(context).size.height * 0.25,
          left: MediaQuery.of(context).size.width * 0.10,
          child: Container(
            child: Text(
              widget.text,
              style: GoogleFonts.roboto(
                fontSize: 30,
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
