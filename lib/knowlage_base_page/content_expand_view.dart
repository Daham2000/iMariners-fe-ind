import 'package:flutter/material.dart';
import '../db/models/category_model.dart';
import '../home_page/widget/sample_widget.dart';
import '../theme/colors.dart';
import '../widgets/app_bar_curve.dart';
import 'expanded_view.dart';

class ContentExpandView extends StatefulWidget {
  final Datum datum;

  const ContentExpandView({Key? key, required this.datum}) : super(key: key);

  @override
  _ContentExpandViewState createState() => _ContentExpandViewState();
}

class _ContentExpandViewState extends State<ContentExpandView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const AppBarCurve(
              text: "Knowledge Base",
              isContent: false,
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
