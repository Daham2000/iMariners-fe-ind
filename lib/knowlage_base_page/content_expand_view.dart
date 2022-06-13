import 'package:flutter/material.dart';
import '../db/models/category_model.dart';
import '../home_page/widget/sample_widget.dart';
import '../theme/colors.dart';
import '../widgets/app_bar_curve.dart';
import 'expanded_view.dart';

class ContentExpandView extends StatefulWidget {
  final String text;
  final Datum datum;

  const ContentExpandView({Key? key, required this.datum, required this.text}) : super(key: key);

  @override
  _ContentExpandViewState createState() => _ContentExpandViewState();
}

class _ContentExpandViewState extends State<ContentExpandView> {
  final GlobalKey<ScaffoldState> _key = GlobalKey(); // Create a key

  void openDrawer() {
    _key.currentState!.openDrawer();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      drawer: DrawerApp(),
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
            ExpandedView(
              datum: widget.datum,
            ),
          ],
        ),
      ),
      backgroundColor: ThemeColors.BACKGROUD_COLOR,
      bottomNavigationBar: const BottomNaviBar(),
    );
  }
}
