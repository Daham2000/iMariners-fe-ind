import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../theme/colors.dart';

class NriCalculator extends StatelessWidget {
  final bool isNri;

  const NriCalculator({Key? key, required this.isNri}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.41,
      height: 38,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(30)),
        color: isNri == true ? Colors.white : ThemeColors.TOGGLE_COLOR,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "NRI Calculator",
            textAlign: TextAlign.center,
            style: GoogleFonts.roboto(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: isNri == true ? ThemeColors.TOGGLE_COLOR : Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}

class SeaTimeCalDesign extends StatelessWidget {
  final bool isNri;

  const SeaTimeCalDesign({Key? key, required this.isNri}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.41,
      height: 38,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(30)),
        color: isNri == false ? Colors.white : ThemeColors.TOGGLE_COLOR,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Sea time Calculator",
            textAlign: TextAlign.center,
            style: GoogleFonts.roboto(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: isNri == false ? ThemeColors.TOGGLE_COLOR : Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}

class DateTimeRow extends StatelessWidget {
  const DateTimeRow({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8, right: 8, bottom: 8),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              border: Border.all(
                width: 1,
                color: ThemeColors.COLOR_BORDER,
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: Text(
                    "26/04/2020",
                    style: GoogleFonts.roboto(
                      fontSize: 15,
                      color: ThemeColors.BACKGROUD_COLOR_BOTTOM,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: Text(
                    "20/06/2020",
                    style: GoogleFonts.roboto(
                      fontSize: 15,
                      color: ThemeColors.BACKGROUD_COLOR_BOTTOM,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    "39",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.roboto(
                      fontSize: 15,
                      color: ThemeColors.BACKGROUD_COLOR_BOTTOM,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    onTap: () {},
                    child: Icon(
                      Icons.delete_forever,
                      color: ThemeColors.BACKGROUD_COLOR_BOTTOM,
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
