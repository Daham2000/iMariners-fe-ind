import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../theme/colors.dart';

class ExpandedView extends StatelessWidget {
  ExpandedView({Key? key}) : super(key: key);
  final List strings = [
    "Celestial Navigation",
    "Terrestrial Navigation",
    "SQA Formula Sheet",
    "HNC/D Formula Sheet"
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: Container(
        width: 400,
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(10))),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                "https://media.istockphoto.com/photos/hands-holding-compass-by-sea-with-crashing-waves-picture-id184622521?k=20&m=184622521&s=612x612&w=0&h=Cdu9xyLxx0AuSetLFVzYeJcIGMUe6Yb_lFABBRkCUHQ=",
                width: 370,
                height: 155,
                fit: BoxFit.fill,
              ),
            ),
            ExpandablePanel(
              header: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  "Navigation",
                  style: GoogleFonts.roboto(
                    fontSize: 20,
                    color: ThemeColors.BACKGROUD_COLOR_BOTTOM,
                  ),
                ),
              ),
              collapsed: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Topics",
                      softWrap: true,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.roboto(
                        fontSize: 20,
                        color: ThemeColors.EXPANED_TEXT_COLOR,
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        for (final i in strings)
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Divider(),
                                Text(
                                  i,
                                  softWrap: true,
                                  maxLines: 1,
                                  textAlign: TextAlign.justify,
                                  overflow: TextOverflow.ellipsis,
                                  style: GoogleFonts.roboto(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: ThemeColors.EXPANED_TEXT_COLOR,
                                  ),
                                ),
                              ],
                            ),
                          )
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              primary: ThemeColors.DOWNLOADBUTTON,
                              onPrimary: Colors.white,
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(32.0),
                              ),
                            ),
                            child: Text(
                              "Download",
                              style: GoogleFonts.roboto(
                                fontSize: 15,
                                color: Colors.blueAccent,
                                fontWeight: FontWeight.bold,
                              ),
                            )),
                      ],
                    ),
                  ],
                ),
              ),
              expanded: Container(),
            )
          ],
        ),
      ),
    );
  }
}
