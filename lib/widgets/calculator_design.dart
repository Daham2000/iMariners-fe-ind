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

class NriDesign extends StatelessWidget {
  const NriDesign({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(14.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          color: Colors.white,
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 8, left: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                    child: Text(
                      "Joining Date",
                      style: GoogleFonts.roboto(
                        fontSize: 15,
                        color: ThemeColors.BACKGROUD_COLOR_BOTTOM,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Text(
                      "Signoff Date",
                      style: GoogleFonts.roboto(
                        fontSize: 15,
                        color: ThemeColors.BACKGROUD_COLOR_BOTTOM,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      "Total Days",
                      style: GoogleFonts.roboto(
                        fontSize: 15,
                        color: ThemeColors.BACKGROUD_COLOR_BOTTOM,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      "",
                      style: GoogleFonts.roboto(
                        fontSize: 15,
                        color: Colors.white,
                      ),
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Column(
              children: [
                const DateTimeRow(),
                const DateTimeRow(),
              ],
            ),
            InkWell(
              onTap: () {},
              child: Container(
                width: 220,
                height: 33,
                decoration: const BoxDecoration(
                    color: ThemeColors.THEME_COLOR,
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Add more calculations",
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.roboto(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 8, bottom: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    width: 139,
                    height: 33,
                    decoration: BoxDecoration(
                        color: ThemeColors.BUTTONRI,
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Total : 38 days",
                          style: GoogleFonts.roboto(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class DateTimePick extends StatelessWidget {
  const DateTimePick({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                "Signon Date",
                style: GoogleFonts.roboto(
                  fontSize: 15,
                  color: ThemeColors.BACKGROUD_COLOR_BOTTOM,
                ),
              ),
            ),
            Container(
              width: 130,
              decoration: BoxDecoration(
                border: Border.all(
                  width: 1,
                  color: ThemeColors.COLOR_BORDER,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                child: Text(
                  "DD/MM/YY",
                  style: GoogleFonts.roboto(
                    fontSize: 15,
                    color: ThemeColors.BACKGROUD_COLOR_BOTTOM,
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 5,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                "Signoff Date",
                style: GoogleFonts.roboto(
                  fontSize: 15,
                  color: ThemeColors.BACKGROUD_COLOR_BOTTOM,
                ),
              ),
            ),
            Container(
              width: 130,
              decoration: BoxDecoration(
                border: Border.all(
                  width: 1,
                  color: ThemeColors.COLOR_BORDER,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                child: Text(
                  "DD/MM/YY",
                  style: GoogleFonts.roboto(
                    fontSize: 15,
                    color: ThemeColors.BACKGROUD_COLOR_BOTTOM,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class ButtonAddMoreCal extends StatelessWidget {
  final String text;
  const ButtonAddMoreCal({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          InkWell(
            onTap: () {},
            child: Container(
              width: 220,
              height: 33,
              decoration: const BoxDecoration(
                  color: ThemeColors.THEME_COLOR,
                  borderRadius: BorderRadius.all(
                      Radius.circular(10))),
              child: Column(
                mainAxisAlignment:
                MainAxisAlignment.center,
                children: [
                  Text(
                    text,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.roboto(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
