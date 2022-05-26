import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../theme/colors.dart';

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
  final text;

  const ActionButton({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.7,
      child: ElevatedButton(
          onPressed: () {},
          child: Text(
            text,
            style: GoogleFonts.roboto(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          )),
    );
  }
}
