import 'package:com_ind_imariners/home_page/widget/sample_widget.dart';
import 'package:com_ind_imariners/login_page/counter_cubit.dart';
import 'package:com_ind_imariners/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../login_page/counter_state.dart';
import '../widgets/app_bar_curve.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<CounterCubit, CounterState>(
        buildWhen: (pre, current) => pre.count != current.count,
        builder: (ctx, state) {
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const AppBarCurve(
                  text: "Home",
                  isContent: false,
                ),
                const SizedBox(
                  height: 40,
                ),
                Padding(
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
                      SizedBox(
                        height: 20,
                      ),
                      CustomHomeButton(
                          i: 1, path: "assets/t.png", text: "Tools"),
                      CustomHomeButton(
                          i: 2, path: "assets/s.png", text: "Knowledge Base"),
                      CustomHomeButton(
                          i: 3, path: "assets/colreg.png", text: "Colreg"),
                      CustomHomeButton(
                          i: 4, path: "assets/e.png", text: "Telegram"),
                    ],
                  ),
                )
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
