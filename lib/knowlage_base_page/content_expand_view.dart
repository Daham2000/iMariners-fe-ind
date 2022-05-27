import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../home_page/widget/sample_widget.dart';
import '../login_page/counter_cubit.dart';
import '../login_page/counter_state.dart';
import '../theme/colors.dart';
import '../widgets/app_bar_curve.dart';

class ContentExpandView extends StatefulWidget {
  const ContentExpandView({Key? key}) : super(key: key);

  @override
  _ContentExpandViewState createState() => _ContentExpandViewState();
}

class _ContentExpandViewState extends State<ContentExpandView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<CounterCubit, CounterState>(
        buildWhen: (pre, current) => pre.count != current.count,
        builder: (ctx, state) {
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const AppBarCurve(
                  text: "Knowledge Base",
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Container(
                    width: 400,
                    color: Colors.white,
                    child: Column(
                      children: [
                        Image.network(
                          "https://media.istockphoto.com/photos/hands-holding-compass-by-sea-with-crashing-waves-picture-id184622521?k=20&m=184622521&s=612x612&w=0&h=Cdu9xyLxx0AuSetLFVzYeJcIGMUe6Yb_lFABBRkCUHQ=",
                          width: 370,
                          height: 155,
                          fit: BoxFit.fill,
                        ),
                        ExpandablePanel(
                          header: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "Navigation",
                              style: GoogleFonts.roboto(
                                fontSize: 20,
                                color: ThemeColors.BACKGROUD_COLOR_BOTTOM,
                              ),
                            ),
                          ),
                          collapsed: Text(
                            "article.body",
                            softWrap: true,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          expanded: Text(
                            "article.bodyddddddddddddddddddd",
                            softWrap: true,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
      backgroundColor: ThemeColors.BACKGROUD_COLOR,
      bottomNavigationBar: const BottomNaviBar(),
    );
  }
}
