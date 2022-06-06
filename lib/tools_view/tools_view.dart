import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../home_page/widget/sample_widget.dart';
import '../login_page/counter_cubit.dart';
import '../login_page/counter_state.dart';
import '../theme/colors.dart';
import '../widgets/app_bar_curve.dart';

class ToolsView extends StatefulWidget {
  const ToolsView({Key? key}) : super(key: key);

  @override
  _ToolsViewState createState() => _ToolsViewState();
}

class _ToolsViewState extends State<ToolsView> {
  bool isNri = false;

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
                  text: "Tools",
                  isContent: false,
                ),
                const SizedBox(
                  height: 18,
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.85,
                  height: 44,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                    color: ThemeColors.TOGGLE_COLOR,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () {
                            setState(() {
                              isNri = true;
                            });
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.41,
                            height: 38,
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30)),
                              color: isNri == true
                                  ? Colors.white
                                  : ThemeColors.TOGGLE_COLOR,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "NRI Calculator",
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.roboto(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: isNri == true
                                        ? ThemeColors.TOGGLE_COLOR
                                        : Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              isNri = false;
                            });
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.41,
                            height: 38,
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30)),
                              color: isNri == false
                                  ? Colors.white
                                  : ThemeColors.TOGGLE_COLOR,                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Sea time Calculator",
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.roboto(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: isNri == false
                                        ? ThemeColors.TOGGLE_COLOR
                                        : Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
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
