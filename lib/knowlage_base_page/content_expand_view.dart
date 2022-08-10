import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../db/api/category_api.dart';
import '../db/models/category_model.dart';
import '../main.dart';
import '../theme/colors.dart';
import '../widgets/app_bar_curve.dart';
import 'expanded_view.dart';

class ContentExpandView extends StatefulWidget {
  final String text;
  Datum datum;

  ContentExpandView({Key? key, required this.datum, required this.text})
      : super(key: key);

  @override
  _ContentExpandViewState createState() => _ContentExpandViewState();
}

class _ContentExpandViewState extends State<ContentExpandView> {
  final GlobalKey<ScaffoldState> _key = GlobalKey(); // Create a key
  bool loading = false;
  final Connectivity _connectivity = Connectivity();
  late ConnectivityResult result;

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
  void initState() {
    if (widget.datum.categoryName == null) {
      loadColreg();
    }
    super.initState();
  }

  loadColreg() async {
    setState(() {
      loading = true;
    });
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? categoryList = prefs.getString('category_list');
    if (categoryList != null) {
      final List<Datum> c = Datum.decode(categoryList);
      List<Datum> filterColreg =
          c.where((element) => element.categoryName == "Colreg").toList();
      if (filterColreg.isNotEmpty) {
        widget.datum = filterColreg[0];
        setState(() {
          loading = false;
        });
        return;
      }
    }
    result = await _connectivity.checkConnectivity();
    if (result != "none") {
      final c = await CategoryAPI().getAddCategories(query: "Colreg");
      if (c.data!.isNotEmpty) {
        widget.datum = c.data![0];
        setState(() {
          loading = false;
        });
      }
    }
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
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AppBarCurve(
              text: widget.text,
              isContent: false,
              openDrawer: openDrawer,
            ),
            const SizedBox(
              height: 25,
            ),
            loading
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : ExpandedView(
                    datum: widget.datum,
                  ),
          ],
        ),
      ),
      // bottomNavigationBar: const BottomNaviBar(),
    );
  }
}
