import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:com_ind_imariners/knowlage_base_page/content_view.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../db/models/category_model.dart';
import '../db/models/user_model.dart';
import '../theme/colors.dart';
import '../widgets/snackbar_factory.dart';
import 'package:http/http.dart' as http;

class Entry {
  final String title;
  final String link;
  final List<Entry>
      children; // Since this is an expansion list ...children can be another list of entries
  Entry(this.title, this.link, [this.children = const <Entry>[]]);
}

class EntryItem extends StatefulWidget {
  const EntryItem(this.entry);

  final Entry entry;

  @override
  _EntryItemState createState() => _EntryItemState();
}

class _EntryItemState extends State<EntryItem> {
  // This function recursively creates the multi-level list rows.
  Widget _buildTiles(Entry root) {
    if (root.children.isEmpty) {
      return root.link != null
          ? InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ContentView(
                              name: root.title,
                              link: root.link == null ? [] : [root.link],
                            )));
              },
              child: ListTile(
                title: Text(root.title),
              ),
            )
          : ListTile(
              title: Text(root.title),
            );
    }
    return ExpansionTile(
      key: PageStorageKey<Entry>(root),
      title: Text(root.title),
      children: root.children.map<Widget>(_buildTiles).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildTiles(widget.entry);
  }
}

class ExpandedView extends StatelessWidget {
  Datum datum = Datum();

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
            EntryItem(
              Entry(
                datum.categoryName ?? "",
                "",
                <Entry>[
                  for (final i in datum.subCategories!)
                    Entry(
                      i.name ?? "",
                      i.subCategories!.length > 0
                          ? ""
                          : i.categoryContentLink![0],
                      <Entry>[
                        for (final ii in i.subCategories!)
                          Entry(ii.name ?? "", ii.categoryContentLink ?? ""),
                      ],
                    ),
                ],
              ),
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
                            await prefs.remove(
                                'category_list');
                            final String? categoryList =
                                prefs.getString('category_list');
                            if (categoryList != null) {
                              final List<Datum> c = Datum.decode(categoryList);
                              final List<Datum> cc = c
                                  .where((i) =>
                                      i.categoryName == datum.categoryName)
                                  .toList();
                              if (cc.isEmpty) {
                                for (int i = 0;
                                    i < datum.subCategories!.length;
                                    i++) {
                                  //Download subcategory content
                                  for (int ii = 0;
                                      ii <
                                          datum.subCategories![i].subCategories!
                                              .length;
                                      ii++) {
                                    print(datum
                                        .subCategories![i]
                                        .subCategories?[ii]
                                        .categoryContentLink);
                                    if (datum.subCategories![i]
                                        .subCategories![ii].categoryContentLink!
                                        .startsWith("https://")) {
                                      final url = Uri.parse(
                                          '${datum.subCategories![i].subCategories?[ii].categoryContentLink}');
                                      final response = await http.get(url);
                                      if (response.body != null) {
                                        datum
                                                .subCategories![i]
                                                .subCategories?[ii]
                                                .categoryContentLink =
                                            response.body;
                                        print(datum
                                            .subCategories![i]
                                            .subCategories?[ii]
                                            .categoryContentLink);
                                      }
                                    }
                                  }
                                  //Download category contents
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
                                        print(datum.subCategories![i]
                                            .categoryContentLink![0]);
                                      }
                                    }
                                  }
                                }
                                c.add(datum);
                                final String encodedData = Datum.encode(c);

                                await prefs.setString(
                                    'category_list', encodedData);
                              }
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
                                      print(datum
                                          .subCategories![i]
                                          .subCategories?[ii]
                                          .categoryContentLink);
                                      print(datum
                                          .subCategories![i]
                                          .subCategories?[ii]
                                          .name);
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
