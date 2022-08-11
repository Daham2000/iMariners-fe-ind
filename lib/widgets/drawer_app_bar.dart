import 'dart:convert';

import 'package:com_ind_imariners/utill/offline_ctrl.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../contact_us_page/contact_us_view.dart';
import '../db/api/auth_api.dart';
import '../db/api/category_api.dart';
import '../db/models/category_model.dart';
import '../db/models/user_model.dart';
import '../login_page/login_provider.dart';
import '../pirvacy_policy_page/privacy_policy_view.dart';
import '../theme/colors.dart';
import 'snackbar_factory.dart';
import 'package:http/http.dart' as http;

class DrawerApp extends StatelessWidget {
  final VoidCallback changeTheme;

  const DrawerApp({Key? key, required this.changeTheme}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double fontSize = MediaQuery.of(context).textScaleFactor;

    return Padding(
      padding: const EdgeInsets.only(top: 35, bottom: 10),
      child: Drawer(
        width: 200,
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const SizedBox(
              height: 50,
            ),
            ListTile(
              title: Text(
                'Upgrade',
                overflow: TextOverflow.clip,
                style: GoogleFonts.roboto(
                    color: ThemeColors.BACKGROUD_COLOR_BOTTOM),
              ),
              leading: const Icon(
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
                leading: const Icon(
                  Icons.download_rounded,
                  color: ThemeColors.BACKGROUD_COLOR_BOTTOM,
                ),
                onTap: () async {
                  final Connectivity _connectivity = Connectivity();
                  ConnectivityResult result =
                      await _connectivity.checkConnectivity();
                  if (result != "none") {
                    final SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    final String? sharedUserData =
                        prefs.getString('userObject');
                    final jsonMap = json.decode(sharedUserData ?? "");
                    UserModel userModel = UserModel.fromJson(jsonMap);
                    //check eligibility for the content download
                    if ((userModel.user?.email == "imariners@hotmail.com") ||
                        userModel.user?.lastPayment != null) {
                      ScaffoldMessenger.of(context)
                          .showSnackBar(SnackBarFactory().getSnackBar(
                        isFail: false,
                        title: "Downloading... This may take few moment",
                        fontSize: fontSize,
                      ));
                      OfflineCtrl().downloadAllContent();
                    } else {
                      ScaffoldMessenger.of(context)
                          .showSnackBar(SnackBarFactory().getSnackBar(
                        isFail: true,
                        title:
                            "To download the content please subscribe to the Premium version",
                        fontSize: fontSize,
                      ));
                    }
                  } else {
                    ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBarFactory().getSnackBar(
                      isFail: false,
                      title: "Sorry, you are offline",
                      fontSize: fontSize,
                    ));
                  }
                }),
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
              onTap: () {
                Future.microtask(() => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ContactUsPage()),
                    ));
              },
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
              leading: const Icon(
                Icons.share,
                color: ThemeColors.BACKGROUD_COLOR_BOTTOM,
              ),
              onTap: () async {
                Navigator.pop(context);
                await FlutterShare.share(
                  title: 'Share iMariners with friends',
                  text: 'Share iMariners with friends',
                  linkUrl: 'https://imariners.com/',
                  chooserTitle: 'Share iMariners with friends',
                );
              },
            ),
            ListTile(
              title: Text(
                'Privacy policy',
                overflow: TextOverflow.clip,
                style: GoogleFonts.roboto(
                    color: ThemeColors.BACKGROUD_COLOR_BOTTOM),
              ),
              leading: const Icon(
                Icons.local_police_sharp,
                color: ThemeColors.BACKGROUD_COLOR_BOTTOM,
              ),
              onTap: () {
                Future.microtask(() => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const PrivacyPolicyView()),
                    ));
              },
            ),
            ListTile(
              title: Text(
                'Logout',
                overflow: TextOverflow.clip,
                style: GoogleFonts.roboto(
                    color: ThemeColors.BACKGROUD_COLOR_BOTTOM),
              ),
              leading: const Icon(
                Icons.person,
                color: ThemeColors.BACKGROUD_COLOR_BOTTOM,
              ),
              onTap: () async {
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBarFactory().getSnackBar(
                  isFail: false,
                  title: "Logging out...",
                  fontSize: fontSize,
                ));
                SharedPreferences prefs = await SharedPreferences.getInstance();
                final String? s = prefs.getString('userObject');
                print(s);
                Map<String, dynamic> userMap = jsonDecode(s ?? "");
                final user = UserModel.fromJson(userMap);
                final int status = await AuthApi().logout(user.user?.id);
                Future.microtask(() => Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => LoginProvider()),
                    ));
              },
            ),
          ],
        ),
      ),
    );
  }
}
