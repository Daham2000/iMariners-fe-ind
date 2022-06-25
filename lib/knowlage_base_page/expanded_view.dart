import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:com_ind_imariners/knowlage_base_page/content_view.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../db/models/category_model.dart';
import '../db/models/user_model.dart';
import '../theme/colors.dart';
import '../widgets/snackbar_factory.dart';
import 'package:http/http.dart' as http;

class ExpandedView extends StatelessWidget {
  final Datum datum;

  ExpandedView({Key? key, required this.datum}) : super(key: key);

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
              child: CachedNetworkImage(
                imageUrl: datum.image!,
                width: 370,
                height: 155,
                fit: BoxFit.fill,
              ),
            ),
            ExpandablePanel(
              header: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  datum.categoryName!,
                  overflow: TextOverflow.clip,
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
                        for (final i in datum.subCategories!)
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ContentView(
                                            name: i.name!,
                                            link: i.categoryContentLink == null
                                                ? []
                                                : i.categoryContentLink!,
                                          )));
                            },
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 10.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Divider(),
                                  Text(
                                    i.name!,
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
                            onPressed: () async {
                              final SharedPreferences prefs =
                                  await SharedPreferences.getInstance();
                              final double fontSize =
                                  MediaQuery.of(context).textScaleFactor;
                              final Connectivity _connectivity = Connectivity();
                              ConnectivityResult result =
                                  await _connectivity.checkConnectivity();
                              if (result != ConnectivityResult.none) {
                                final String? sharedUserData =
                                    prefs.getString('userObject');
                                final jsonMap =
                                    json.decode(sharedUserData ?? "");
                                UserModel userModel =
                                    UserModel.fromJson(jsonMap);

                                //check if admin or user
                                if ((userModel.user?.email ==
                                        "imariners@hotmail.com") ||
                                    userModel.user?.lastPayment != null) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBarFactory().getSnackBar(
                                    isFail: false,
                                    title: "Downloading...",
                                    fontSize: fontSize,
                                  ));

                                  final String? categoryList =
                                      prefs.getString('category_list');

                                  if (categoryList != null) {
                                    final List<Datum> c =
                                        Datum.decode(categoryList);
                                    final List<Datum> cc = c
                                        .where((i) =>
                                            i.categoryName ==
                                            datum.categoryName)
                                        .toList();
                                    if (cc.isEmpty) {
                                      for (int i = 0;
                                          i < datum.subCategories!.length;
                                          i++) {
                                        print(datum.subCategories![i]
                                            .categoryContentLink);
                                        for (int ii = 0;
                                            ii <
                                                datum
                                                    .subCategories![i]
                                                    .categoryContentLink!
                                                    .length;
                                            ii++) {
                                          if (datum.subCategories![i]
                                              .categoryContentLink![0]
                                              .startsWith("https://")) {
                                            final url = Uri.parse(
                                                '${datum.subCategories![i].categoryContentLink![0]}');
                                            final response =
                                                await http.get(url);
                                            if (response.body != null) {
                                              datum.subCategories![i]
                                                      .categoryContentLink![0] =
                                                  response.body;
                                              print(datum.subCategories![i]
                                                  .categoryContentLink![0]);
                                            }
                                          }
                                        }
                                      }
                                      c.add(datum);
                                      final String encodedData =
                                          Datum.encode(c);

                                      await prefs.setString(
                                          'category_list', encodedData);
                                    }
                                  } else {
                                    for (int i = 0;
                                        i < datum.subCategories!.length;
                                        i++) {
                                      for (int ii = 0;
                                          ii <
                                              datum.subCategories![i]
                                                  .categoryContentLink!.length;
                                          ii++) {
                                        if (datum.subCategories![i]
                                            .categoryContentLink![0]
                                            .startsWith("https://")) {
                                          final url = Uri.parse(
                                              '${datum.subCategories![i].categoryContentLink![0]}');
                                          final response = await http.get(url);
                                          if (response.body != null) {
                                            datum.subCategories![i]
                                                    .categoryContentLink![0] =
                                                response.body;
                                          }
                                        }
                                      }
                                    }
                                    final String encodedData =
                                        Datum.encode([datum]);

                                    await prefs.setString(
                                        'category_list', encodedData);
                                  }
                                } else {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBarFactory().getSnackBar(
                                    isFail: true,
                                    title:
                                    "To download the content please subscribe to the Premium version",
                                    fontSize: fontSize,
                                  ));
                                }
                              }else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBarFactory().getSnackBar(
                                      isFail: true,
                                      title: "Sorry you are offline",
                                      fontSize: fontSize,
                                    ));
                              }
                            },
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
                              overflow: TextOverflow.clip,
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
