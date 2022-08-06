import 'dart:async';

import 'package:com_ind_imariners/db/models/category_model.dart';
import 'package:com_ind_imariners/login_page/counter_cubit.dart';
import 'package:com_ind_imariners/login_page/counter_state.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '../home_page/widget/sample_widget.dart';
import '../main.dart';
import '../theme/colors.dart';
import '../widgets/app_bar_curve.dart';

class KnowledgeBaseView extends StatefulWidget {

  const KnowledgeBaseView({Key? key})
      : super(key: key);

  @override
  _KnowledgeBaseViewState createState() => _KnowledgeBaseViewState();
}

class _KnowledgeBaseViewState extends State<KnowledgeBaseView> {
  late CounterCubit counterCubit;
  final TextEditingController searchFieldCtrl = TextEditingController();
  bool isSearching = false;
  final Connectivity _connectivity = Connectivity();

  final GlobalKey<ScaffoldState> _key = GlobalKey(); // Create a key
  @override
  void initState() {
    counterCubit = BlocProvider.of<CounterCubit>(context);
    StreamSubscription<ConnectivityResult> _connectivitySubscription =
    _connectivity.onConnectivityChanged.listen(counterCubit.setOffline);
    loadCategories();
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
  late ConnectivityResult result;

  loadCategories() async {
    try {
      result = await _connectivity.checkConnectivity();
      await counterCubit.loadCategories(result.name == "none");
    } on PlatformException catch (e) {
      return;
    }
  }

  TextFormField getSearchTextField() {
    return TextFormField(
      controller: searchFieldCtrl,
      cursorColor: Colors.black,
      onChanged: (e) async {
        await counterCubit.loadCategories(result.name == "none",query: e.toLowerCase());
      },
      decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            // width: 0.0 produces a thin "hairline" border
            borderSide: const BorderSide(color: Colors.grey, width: 0.5),
            borderRadius: BorderRadius.circular(50.0),
          ),
          hintStyle: TextStyle(color: Colors.grey[400]),
          hintText: "Search courses",
          fillColor: Colors.white70),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      backgroundColor: MyApp.themeNotifier.value == ThemeMode.light
          ? ThemeColors.BACKGROUD_COLOR
          : Colors.grey,
      drawer: DrawerApp(
        changeTheme: changeTheme,
      ),
      body: BlocBuilder<CounterCubit, CounterState>(
        buildWhen: (pre, current) =>
            pre.count != current.count ||
            pre.loading != current.loading ||
            pre.categoryModel != current.categoryModel ||
            pre.isSearching != current.isSearching,
        builder: (ctx, state) {
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                AppBarCurve(
                  text: "Knowledge Base",
                  isContent: false,
                  openDrawer: openDrawer,
                ),
                const SizedBox(
                  height: 20,
                ),
                const SizedBox(
                  height: 15,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AnimatedSwitcher(
                          duration: const Duration(milliseconds: 500),
                          transitionBuilder:
                              (Widget child, Animation<double> animation) {
                            return ScaleTransition(
                                scale: animation, child: child);
                          },
                          child: state.isSearching
                              ? getSearchTextField()
                              : Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    TopicHomePage(
                                      counterCubit: counterCubit,
                                    ),
                                  ],
                                ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Text(
                            "Your Courses",
                            style: GoogleFonts.roboto(
                              fontSize: 19,
                              color: ThemeColors.BACKGROUD_COLOR_BOTTOM,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        state.loading
                            ? Center(
                                child: CircularProgressIndicator(),
                              )
                            : state.categoryModel.data!=null ? Column(
                                children: [
                                  for (int i = 0;
                                      i < state.categoryModel.data!.length;
                                      i = i + 2)
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        CategoryViewCard(
                                          datum: state.categoryModel.data![i],
                                        ),
                                        state.categoryModel.data!.length > i+1
                                            ? CategoryViewCard(
                                                datum: state.categoryModel
                                                    .data![i + 1])
                                            : Container(),
                                      ],
                                    ),
                                ],
                              ): Container(),
                      ],
                    ),
                  ),
                )
              ],
            ),
          );
        },
      ),
      // bottomNavigationBar: const BottomNaviBar(),
    );
  }
}
