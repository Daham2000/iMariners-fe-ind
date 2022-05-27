import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../theme/colors.dart';

class CustomHomeButton extends StatelessWidget {
  final int i;
  final String path;
  final String text;

  const CustomHomeButton(
      {Key? key, required this.i, required this.path, required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 66,
        child: ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              primary: i == 1
                  ? ThemeColors.HOMEBUTTONONE
                  : i == 2
                      ? ThemeColors.HOMEBUTTONTWO
                      : ThemeColors.HOMEBUTTONTHREE,
            ),
            child: Row(
              children: [
                Image.asset(
                  path,
                  width: 40,
                  color: Colors.white,
                ),
                SizedBox(
                  width: 12,
                ),
                Text(
                  text,
                  style: GoogleFonts.roboto(fontSize: 23),
                )
              ],
            )),
      ),
    );
  }
}

class BottomNaviBar extends StatelessWidget {
  const BottomNaviBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 12),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.06,
        padding: const EdgeInsets.only(top: 5),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(50.0),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Column(
                children: [
                  Image.asset(
                    "assets/home.png",
                    width: 25,
                  ),
                  RichText(
                    text: TextSpan(
                      text: 'Home',
                      style: GoogleFonts.roboto(
                          fontSize: 10,
                          color: ThemeColors.BACKGROUD_COLOR_BOTTOM),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Column(
                children: [
                  Image.asset(
                    "assets/upgrade.png",
                    width: 25,
                  ),
                  Text(
                    "Upgrade",
                    style: GoogleFonts.roboto(
                        fontSize: 12,
                        color: ThemeColors.BACKGROUD_COLOR_BOTTOM),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Column(
                children: [
                  Image.asset(
                    "assets/search_icon.png",
                    width: 25,
                  ),
                  Text(
                    "Search",
                    style: GoogleFonts.roboto(
                        fontSize: 12,
                        color: ThemeColors.BACKGROUD_COLOR_BOTTOM),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Column(
                children: [
                  Image.asset(
                    "assets/Shutdown.png",
                    width: 25,
                  ),
                  Text(
                    "Logout",
                    style: GoogleFonts.roboto(
                        fontSize: 12,
                        color: ThemeColors.BACKGROUD_COLOR_BOTTOM),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

