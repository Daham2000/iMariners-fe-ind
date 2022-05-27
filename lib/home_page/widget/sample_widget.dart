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
