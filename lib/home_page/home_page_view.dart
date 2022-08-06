import 'dart:async';

import 'package:com_ind_imariners/home_page/widget/sample_widget.dart';
import 'package:com_ind_imariners/login_page/counter_cubit.dart';
import 'package:com_ind_imariners/theme/colors.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../db/api/category_api.dart';
import '../db/models/category_model.dart';
import '../knowlage_base_page/KnowlageBaseViewPrivider.dart';
import '../knowlage_base_page/content_expand_view.dart';
import '../login_page/counter_state.dart';
import '../main.dart';
import '../telegram_view/telegram_view.dart';
import '../tools_view/tools_provider.dart';
import '../widgets/app_bar_curve.dart';
import '../widgets/snackbar_factory.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final Connectivity _connectivity = Connectivity();
  late CounterCubit counterCubit;
  final GlobalKey<ScaffoldState> _key = GlobalKey(); // Create a key

  @override
  void initState() {
    counterCubit = BlocProvider.of<CounterCubit>(context);
    StreamSubscription<ConnectivityResult> _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(counterCubit.setOffline);
    super.initState();
  }

  void openDrawer() {
    _key.currentState!.openDrawer();
  }

  void changeTheme() {
    setState(() {
      MyApp.themeNotifier.value = MyApp.themeNotifier.value == ThemeMode.light
          ? ThemeMode.dark
          : ThemeMode.light;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      drawer: DrawerApp(
        changeTheme: changeTheme,
      ),
      body: BlocBuilder<CounterCubit, CounterState>(
        buildWhen: (pre, current) =>
            pre.count != current.count ||
            pre.loading != current.loading ||
            pre.isOffline != current.isOffline ||
            pre.isDarkMode != current.isDarkMode ||
            pre.categoryModel != current.categoryModel,
        builder: (ctx, state) {
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppBarCurve(
                  text: "Home",
                  isContent: false,
                  openDrawer: openDrawer,
                ),
                const SizedBox(
                  height: 40,
                ),
                state.loading
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Welcome",
                              textAlign: TextAlign.start,
                              style: GoogleFonts.roboto(
                                fontSize: 23,
                                color: ThemeColors.WELCOME,
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            InkWell(
                              onTap: () async {
                                  Future.microtask(() => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            ContentExpandView(
                                              datum: Datum(),
                                              text: "Colreg",
                                            )),
                                  ));
                              },
                              child: const CustomHomeButton(
                                  i: 3,
                                  path: "assets/colreg.png",
                                  text: "Colreg"),
                            ),
                            InkWell(
                              onTap: () {
                                Future.microtask(() => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          KnowlageBaseProvider(
                                          )),
                                ));
                              },
                              child: const CustomHomeButton(
                                  i: 2,
                                  path: "assets/s.png",
                                  text: "Knowledge Base"),
                            ),
                            InkWell(
                              onTap: () {
                                Future.microtask(() => Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              ToolsProvider()),
                                    ));
                              },
                              child: CustomHomeButton(
                                  i: 1, path: "assets/t.png", text: "Tools"),
                            ),
                            InkWell(
                              onTap: () {
                                if (state.isOffline) {
                                  final double fontSize =
                                      MediaQuery.of(context).textScaleFactor;
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBarFactory().getSnackBar(
                                    isFail: false,
                                    title: "Your are offline",
                                    fontSize: fontSize,
                                  ));
                                } else {
                                  Future.microtask(() => Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                TelegramView()),
                                      ));
                                }
                              },
                              child: const CustomHomeButton(
                                  i: 4, path: "assets/e.png", text: "Telegram"),
                            ),
                          ],
                        ),
                      )
              ],
            ),
          );
        },
      ),
      backgroundColor: MyApp.themeNotifier.value == ThemeMode.light
          ? ThemeColors.BACKGROUD_COLOR
          : Colors.grey,
      // bottomNavigationBar: const BottomNaviBar(),
    );
  }
}
