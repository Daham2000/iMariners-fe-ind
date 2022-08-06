import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../db/models/category_model.dart';
import '../db/models/user_model.dart';
import '../theme/colors.dart';
import '../widgets/snackbar_factory.dart';
import 'package:http/http.dart' as http;

import 'content_view.dart';

class ExpandedView extends StatefulWidget {
  Datum datum = Datum();

  ExpandedView({Key? key, required this.datum}) : super(key: key);

  @override
  _ExpandedViewState createState() => _ExpandedViewState();
}

class _ExpandedViewState extends State<ExpandedView> {
  Datum datum = Datum();

  @override
  void initState() {
    datum = widget.datum;
    super.initState();
  }

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
            ExpansionTile(
              title: Text(datum.categoryName ?? ""),
              children: [
                for (final i in datum.subCategories!)
                  ExpansionTile(
                    title: InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ContentView(
                                      name: i.name ?? "",
                                      link: i.categoryContentLink == null
                                          ? []
                                          : i.categoryContentLink ?? [],
                                    )));
                      },
                      child: Text(i.name ?? ""),
                    ),
                    children: [
                      for (final SubCategorySubCategory j
                          in i.subCategories ?? [])
                        ExpansionTile(
                          trailing: Icon(
                            Icons.keyboard_arrow_down_outlined,
                            color: j.topicSubCategories!.isEmpty
                                ? Colors.white
                                : Colors.black,
                          ),
                          title: InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ContentView(
                                            name: j.name ?? "",
                                            link: j.categoryContentLink == null
                                                ? []
                                                : [j.categoryContentLink ?? ""],
                                          )));
                            },
                            child: Text(j.name ?? ""),
                          ),
                          children: [
                            for (final q in j.topicSubCategories ?? [])
                              ExpansionTile(
                                trailing: Icon(
                                  Icons.arrow_drop_down,
                                  color: Colors.white,
                                ),
                                title: InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => ContentView(
                                                  name: q.name,
                                                  link: q.categoryContentLink ==
                                                          null
                                                      ? []
                                                      : [q.categoryContentLink],
                                                )));
                                  },
                                  child: Text(q.name ?? ""),
                                ),
                              ),
                          ],
                        ),
                    ],
                  ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Row(
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
                          final jsonMap = json.decode(sharedUserData ?? "");
                          UserModel userModel = UserModel.fromJson(jsonMap);

                          //check if admin or user
                          if ((userModel.user?.email ==
                                  "imariners@hotmail.com") ||
                              userModel.user?.lastPayment != null) {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(SnackBarFactory().getSnackBar(
                              isFail: false,
                              title: "Downloading...",
                              fontSize: fontSize,
                            ));
                            final String? categoryList =
                                prefs.getString('category_list');
                            if (categoryList != null) {
                              final List<Datum> c = Datum.decode(categoryList);
                              final List<Datum> cc = c
                                  .where((i) =>
                                      i.categoryName == datum.categoryName)
                                  .toList();
                              for (int i = 0;
                                  i < datum.subCategories!.length;
                                  i++) {
                                //Download subcategory content
                                for (int ii = 0;
                                    ii <
                                        datum.subCategories![i].subCategories!
                                            .length;
                                    ii++) {
                                  if (datum.subCategories![i].subCategories![ii]
                                      .categoryContentLink!
                                      .startsWith("https://")) {
                                    final url = Uri.parse(
                                        '${datum.subCategories![i].subCategories?[ii].categoryContentLink}');
                                    final response = await http.get(url);
                                    if (response.body != null) {
                                      datum.subCategories![i].subCategories?[ii]
                                          .categoryContentLink = response.body;
                                    }
                                  }

                                  //Subcategory topic download
                                  for (int j = 0;
                                      j <
                                          datum
                                              .subCategories![i]
                                              .subCategories![ii]
                                              .topicSubCategories!
                                              .length;
                                      j++) {
                                    if (datum
                                        .subCategories![i]
                                        .subCategories![ii]
                                        .topicSubCategories![j]
                                        .categoryContentLink!
                                        .startsWith("https://")) {
                                      final url = Uri.parse(
                                          '${datum.subCategories![i].subCategories?[ii].topicSubCategories![j].categoryContentLink}');
                                      final response = await http.get(url);
                                      print("Html: ${response.body}");
                                      if (response.body != null) {
                                        datum
                                                .subCategories![i]
                                                .subCategories![ii]
                                                .topicSubCategories![j]
                                                .categoryContentLink =
                                            response.body;
                                        print("Content: ${datum
                                            .subCategories![i]
                                            .subCategories![ii]
                                            .topicSubCategories![j]
                                            .categoryContentLink}");
                                      }
                                    }
                                  }
                                }
                                //Download category contents
                                if (datum.subCategories![i].categoryContentLink!
                                    .isNotEmpty) {
                                  if (datum
                                      .subCategories![i].categoryContentLink![0]
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
                              if (cc.isEmpty) {
                                c.add(datum);
                              } else {
                                final int index = c.indexWhere((note) => note
                                    .categoryName!
                                    .startsWith(datum.categoryName ?? ""));
                                if (index > -1) {
                                  c[index] = datum;
                                }
                              }
                              final String encodedData = Datum.encode(c);
                              await prefs.setString(
                                  'category_list', encodedData);
                            } else {
                              for (int i = 0;
                                  i < datum.subCategories!.length;
                                  i++) {
                                for (int ii = 0;
                                    ii <
                                        datum.subCategories![i].subCategories!
                                            .length;
                                    ii++) {
                                  if (datum.subCategories![i].subCategories![ii]
                                      .categoryContentLink!
                                      .startsWith("https://")) {
                                    final url = Uri.parse(
                                        '${datum.subCategories![i].subCategories?[ii].categoryContentLink}');
                                    final response = await http.get(url);
                                    if (response.body != null) {
                                      datum.subCategories![i].subCategories?[ii]
                                          .categoryContentLink = response.body;
                                    }
                                  }
                                  //Subcategory topic download
                                  for (int j = 0;
                                  j <
                                      datum
                                          .subCategories![i]
                                          .subCategories![ii]
                                          .topicSubCategories!
                                          .length;
                                  j++) {
                                    if (datum
                                        .subCategories![i]
                                        .subCategories![ii]
                                        .topicSubCategories![j]
                                        .categoryContentLink!
                                        .startsWith("https://")) {

                                      final url = Uri.parse(
                                          '${datum.subCategories![i].subCategories?[ii].topicSubCategories![j].categoryContentLink}');
                                      final response = await http.get(url);
                                      print("Html: ${response.body}");
                                      if (response.body != null) {
                                        datum
                                            .subCategories![i]
                                            .subCategories![ii]
                                            .topicSubCategories![j]
                                            .categoryContentLink =
                                            response.body;
                                        print("Content: ${datum
                                            .subCategories![i]
                                            .subCategories![ii]
                                            .topicSubCategories![j]
                                            .categoryContentLink}");
                                      }
                                    }
                                  }
                                }
                                for (int ii = 0;
                                    ii <
                                        datum.subCategories![i]
                                            .categoryContentLink!.length;
                                    ii++) {
                                  if (datum
                                      .subCategories![i].categoryContentLink![0]
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
                              final String encodedData = Datum.encode([datum]);

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
                        } else {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(SnackBarFactory().getSnackBar(
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
            ),
          ],
        ),
      ),
    );
  }
}
