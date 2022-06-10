import 'package:com_ind_imariners/tools_view/tools_provider.dart';
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
            onPressed: () {
              Future.microtask(() => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ToolsProvider()),
                  ));
            },
            style: ElevatedButton.styleFrom(
              primary: i == 1
                  ? ThemeColors.HOMEBUTTONONE
                  : i == 2
                      ? ThemeColors.HOMEBUTTONTWO
                      : i == 3
                          ? ThemeColors.ColregColor
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

class TopicHomePage extends StatelessWidget {
  const TopicHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Pollution prevention, Response, and \n compensation ",
          textAlign: TextAlign.center,
          style: GoogleFonts.roboto(
            fontSize: 19,
            fontWeight: FontWeight.bold,
            color: ThemeColors.BACKGROUD_COLOR_BOTTOM,
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        Container(
          height: 31,
          child: ElevatedButton(
              onPressed: () {},
              child: Text("Take Course"),
              style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50.0),
                          side: BorderSide(color: ThemeColors.THEME_COLOR))))),
        )
      ],
    );
  }
}

class CategoryViewCard extends StatelessWidget {
  const CategoryViewCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
      child: InkWell(
        onTap: () {},
        child: Container(
          width: MediaQuery.of(context).size.width * 0.4,
          height: 190,
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(10))),
          child: Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.4,
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  // Image border
                  child: Image.network(
                    "https://media.istockphoto.com/photos/hands-holding-compass-by-sea-with-crashing-waves-picture-id184622521?k=20&m=184622521&s=612x612&w=0&h=Cdu9xyLxx0AuSetLFVzYeJcIGMUe6Yb_lFABBRkCUHQ=",
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 10.0, vertical: 10.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Navigation",
                          style: GoogleFonts.roboto(
                            fontSize: 16,
                            color: ThemeColors.BACKGROUD_COLOR_BOTTOM,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 1.0, vertical: 5.0),
                      child: Row(
                        children: [
                          Container(
                            width: 15,
                            child: Image.asset(
                              "assets/s.png",
                              color: Colors.grey,
                            ),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            "7 Lectures",
                            style: GoogleFonts.roboto(
                              fontSize: 13.0,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 1.0, vertical: 1.0),
                      child: Row(
                        children: [
                          Container(
                            width: 15,
                            child: Image.asset(
                              "assets/people.png",
                              color: Colors.grey,
                            ),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            "23 Learners",
                            style: GoogleFonts.roboto(
                              fontSize: 13.0,
                              color: Colors.grey,
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
      ),
    );
  }
}
