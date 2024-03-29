import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:com_ind_imariners/db/api/auth_api.dart';
import 'package:com_ind_imariners/home_page/home_provider.dart';
import 'package:com_ind_imariners/login_page/login_provider.dart';
import 'package:com_ind_imariners/widgets/search_bar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../db/models/category_model.dart';
import '../../db/models/user_model.dart';
import '../../knowlage_base_page/content_expand_view.dart';
import '../../login_page/counter_cubit.dart';
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
        decoration: BoxDecoration(
          color: ThemeColors.THEME_COLOR,
          // color: i == 1
          //     ? ThemeColors.HOMEBUTTONONE
          //     : i == 2
          //     ? ThemeColors.HOMEBUTTONTWO
          //     : i == 3
          //     ? ThemeColors.ColregColor
          //     : ThemeColors.HOMEBUTTONTHREE,
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
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
                style: GoogleFonts.roboto(
                  fontSize: 23,
                  color: Colors.white,
                ),
              )
            ],
          ),
        ),
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
              child: InkWell(
                onTap: () {
                  Future.microtask(() => Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => HomeProvider()),
                      ));
                },
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
            InkWell(
              onTap: () {
                Future.microtask(() => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SearchBar()),
                    ));
              },
              child: Padding(
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
            ),
            InkWell(
              onTap: () async {
                SharedPreferences prefs = await SharedPreferences.getInstance();
                final String? s = prefs.getString('userObject');
                Map<String, dynamic> userMap = jsonDecode(s ?? "");
                final user = UserModel.fromJson(userMap);
                final int status = await AuthApi().logout(user.user?.id);
                if (status == 200) {
                  Future.microtask(() => Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => LoginProvider()),
                      ));
                }
              },
              child: Padding(
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
            ),
          ],
        ),
      ),
    );
  }
}

class TopicHomePage extends StatelessWidget {
  final CounterCubit counterCubit;

  const TopicHomePage({Key? key, required this.counterCubit}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: 31,
          child: ElevatedButton(
              onPressed: () {
                counterCubit.searchContent(true);
                print(counterCubit.state.isSearching);
              },
              style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50.0),
                          side: BorderSide(color: ThemeColors.THEME_COLOR)))),
              child: const Text("Take Course")),
        )
      ],
    );
  }
}

class CategoryViewCard extends StatelessWidget {
  final Datum datum;

  CategoryViewCard({Key? key, required Datum this.datum}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
      child: InkWell(
        onTap: () {
          Future.microtask(() => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ContentExpandView(
                          datum: datum,
                          text: "Knowledge Base",
                        )),
              ));
        },
        child: Container(
          width: MediaQuery.of(context).size.width * 0.4,
          height: 150,
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(10))),
          child: Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.4,
                height: 100,
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  // Image border
                  child: CachedNetworkImage(
                    fit: BoxFit.fill,
                    imageUrl: datum.image!,
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
                          datum.categoryName!,
                          overflow: TextOverflow.clip,
                          style: GoogleFonts.roboto(
                            fontSize: 16,
                            color: ThemeColors.BACKGROUD_COLOR_BOTTOM,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
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
