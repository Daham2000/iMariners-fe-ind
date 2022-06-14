import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:com_ind_imariners/db/models/category_model.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../db/api/category_api.dart';
import '../main.dart';
import '../theme/colors.dart';
import 'snackbar_factory.dart';
import 'package:http/http.dart' as http;

class AppBarCurve extends StatefulWidget {
  final String text;
  final bool isContent;
  final VoidCallback openDrawer;

  const AppBarCurve(
      {Key? key,
      required this.text,
      required this.isContent,
      required this.openDrawer})
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
        widget.text != "Login"
            ? widget.text != "Create Your Account"
                ? Positioned(
                    top: MediaQuery.of(context).size.height * -0.038,
                    left: MediaQuery.of(context).size.width * 0,
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.29,
                      child: SvgPicture.asset("assets/appbar_rec.svg"),
                    ),
                  )
                : Container()
            : Container(),
        widget.text != "Login"
            ? widget.text != "Create Your Account"
                ? Positioned(
                    top: MediaQuery.of(context).size.height * 0.055,
                    left: MediaQuery.of(context).size.width * 0.01,
                    child: InkWell(
                      onTap: () {
                        widget.openDrawer();
                      },
                      child: Container(
                          width: MediaQuery.of(context).size.width * 0.07,
                          child: Image.asset("assets/menu.png")),
                    ),
                  )
                : Container()
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
                                  : MediaQuery.of(context).size.height * 0.22,
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
              overflow: TextOverflow.clip,
              style: GoogleFonts.roboto(
                fontSize: widget.text == "Knowledge Base"
                    ? 24
                    : widget.isContent
                        ? 23
                        : 30,
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

class DrawerApp extends StatelessWidget {

  final VoidCallback changeTheme;

  const DrawerApp({Key? key, required this.changeTheme}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 35, bottom: 10),
      child: Drawer(
        width: 200,
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            SizedBox(
              height: 50,
            ),
            ListTile(
              title: Text(
                'Upgrade',
                overflow: TextOverflow.clip,
                style: GoogleFonts.roboto(
                    color: ThemeColors.BACKGROUD_COLOR_BOTTOM),
              ),
              leading: Icon(
                Icons.upgrade_outlined,
                color: ThemeColors.BACKGROUD_COLOR_BOTTOM,
              ),
              onTap: () {},
            ),
            ListTile(
              title: Text(
                'Download all',
                overflow: TextOverflow.clip,
                style: GoogleFonts.roboto(
                    color: ThemeColors.BACKGROUD_COLOR_BOTTOM),
              ),
              leading: Icon(
                Icons.download_rounded,
                color: ThemeColors.BACKGROUD_COLOR_BOTTOM,
              ),
              onTap: () async {
                final Connectivity _connectivity = Connectivity();
                ConnectivityResult result =
                    await _connectivity.checkConnectivity();
                if (result != "none") {
                  final categories = await CategoryAPI().getAddCategories();

                  final double fontSize =
                      MediaQuery.of(context).textScaleFactor;
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBarFactory().getSnackBar(
                    isFail: false,
                    title: "Downloading...",
                    fontSize: fontSize,
                  ));
                  final SharedPreferences prefs =
                      await SharedPreferences.getInstance();

                  final String? categoryList = prefs.getString('category_list');

                  for (Datum datum in categories.data ?? []) {
                    if (categoryList != null) {
                      final List<Datum> c = Datum.decode(categoryList);
                      final List<Datum> cc = c
                          .where((i) => i.categoryName == datum.categoryName)
                          .toList();
                      if (cc.isEmpty) {
                        for (int i = 0; i < datum.subCategories!.length; i++) {
                          print(datum.subCategories![i].categoryContentLink);
                          for (int ii = 0;
                              ii <
                                  datum.subCategories![i].categoryContentLink!
                                      .length;
                              ii++) {
                            if (datum.subCategories![i].categoryContentLink![0]
                                .startsWith("https://")) {
                              final url = Uri.parse(
                                  '${datum.subCategories![i].categoryContentLink![0]}');
                              final response = await http.get(url);
                              if (response.body != null) {
                                datum.subCategories![i]
                                    .categoryContentLink![0] = response.body;
                                print(datum
                                    .subCategories![i].categoryContentLink![0]);
                              }
                            }
                          }
                        }
                        c.add(datum);
                        final String encodedData = Datum.encode(c);

                        await prefs.setString('category_list', encodedData);
                      }
                    } else {
                      for (int i = 0; i < datum.subCategories!.length; i++) {
                        print(datum.subCategories![i].categoryContentLink);
                        for (int ii = 0;
                            ii <
                                datum.subCategories![i].categoryContentLink!
                                    .length;
                            ii++) {
                          if (datum.subCategories![i].categoryContentLink![0]
                              .startsWith("https://")) {
                            final url = Uri.parse(
                                '${datum.subCategories![i].categoryContentLink![0]}');
                            final response = await http.get(url);
                            if (response.body != null) {
                              datum.subCategories![i].categoryContentLink![0] =
                                  response.body;
                              print(datum
                                  .subCategories![i].categoryContentLink![0]);
                            }
                          }
                        }
                      }
                      print(datum.subCategories![0].categoryContentLink![0]);
                      final String encodedData = Datum.encode([datum]);

                      await prefs.setString('category_list', encodedData);
                    }
                    ScaffoldMessenger.of(context).clearSnackBars();
                  }
                }
              },
            ),
            ListTile(
              title: Text(
                'Theme',
                overflow: TextOverflow.clip,
                style: GoogleFonts.roboto(
                    color: ThemeColors.BACKGROUD_COLOR_BOTTOM),
              ),
              leading: Icon(
                Icons.toggle_off,
                color: ThemeColors.BACKGROUD_COLOR_BOTTOM,
              ),
              onTap: () async {
                changeTheme();
              },
            ),
            ListTile(
              title: Text(
                'Contact us',
                overflow: TextOverflow.clip,
                style: GoogleFonts.roboto(
                    color: ThemeColors.BACKGROUD_COLOR_BOTTOM),
              ),
              leading: Icon(
                Icons.person,
                color: ThemeColors.BACKGROUD_COLOR_BOTTOM,
              ),
              onTap: () {},
            ),
            ListTile(
              title: Text(
                'Feature requests',
                overflow: TextOverflow.clip,
                style: GoogleFonts.roboto(
                    color: ThemeColors.BACKGROUD_COLOR_BOTTOM),
              ),
              leading: Icon(
                Icons.request_page,
                color: ThemeColors.BACKGROUD_COLOR_BOTTOM,
              ),
              onTap: () {},
            ),
            ListTile(
              title: Text(
                'Share app',
                overflow: TextOverflow.clip,
                style: GoogleFonts.roboto(
                    color: ThemeColors.BACKGROUD_COLOR_BOTTOM),
              ),
              leading: Icon(
                Icons.share,
                color: ThemeColors.BACKGROUD_COLOR_BOTTOM,
              ),
              onTap: () {},
            ),
            ListTile(
              title: Text(
                'Privacy policy',
                overflow: TextOverflow.clip,
                style: GoogleFonts.roboto(
                    color: ThemeColors.BACKGROUD_COLOR_BOTTOM),
              ),
              leading: Icon(
                Icons.local_police_sharp,
                color: ThemeColors.BACKGROUD_COLOR_BOTTOM,
              ),
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}
