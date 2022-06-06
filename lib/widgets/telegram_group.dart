import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../theme/colors.dart';

class GroupUI extends StatelessWidget {
  const GroupUI({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Container(
        width: 352,
        height: 181,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(10))),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(
                    Icons.group,
                    color: ThemeColors.BACKGROUD_COLOR_BOTTOM,
                    size: 25,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    "Group 1",
                    style: GoogleFonts.roboto(
                      color: ThemeColors.BACKGROUD_COLOR_BOTTOM,
                      fontSize: 18,
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "https://dhjshjbjgisseootjjjymnmnfmdnkk.com",
                style: GoogleFonts.roboto(
                  color: Colors.blue,
                  fontSize: 18,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    onPressed: () {},
                    child: Text("Join"),
                    style: ElevatedButton.styleFrom(
                      primary: ThemeColors.HOMEBUTTONTHREE, // background
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
