import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../home_page/widget/sample_widget.dart';
import '../login_page/counter_cubit.dart';
import '../login_page/counter_state.dart';
import '../main.dart';
import '../theme/colors.dart';
import '../widgets/app_bar_curve.dart';
import '../widgets/calculator_design.dart';

class ToolsView extends StatefulWidget {
  const ToolsView({Key? key}) : super(key: key);

  @override
  _ToolsViewState createState() => _ToolsViewState();
}

class _ToolsViewState extends State<ToolsView> {
  bool isNri = true;
  List<DateTime> joiningDate = [];
  List<DateTime> signOffDate = [];
  int total = 0;
  DateTime dateOne = DateTime.now();
  DateTime dateTwo = DateTime.now();
  DateFormat dateFormat = DateFormat("yyyy-MM-dd");
  final GlobalKey<ScaffoldState> _key = GlobalKey(); // Create a key

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
    CounterCubit counterCubit = BlocProvider.of<CounterCubit>(context);
    String joiningDateI = dateFormat.format(dateOne);
    String signOffDateI = dateFormat.format(dateTwo);
    final double fontSize = MediaQuery.of(context).textScaleFactor;

    return Scaffold(
      key: _key,
      backgroundColor: MyApp.themeNotifier.value == ThemeMode.light
          ? ThemeColors.BACKGROUD_COLOR
          : Colors.grey,
      drawer: DrawerApp(changeTheme: changeTheme,),
      body: BlocBuilder<CounterCubit, CounterState>(
        buildWhen: (pre, current) => pre.count != current.count,
        builder: (ctx, state) {
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                AppBarCurve(
                  text: "Tools",
                  openDrawer: openDrawer,
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
                          child: NriCalculator(
                            isNri: isNri,
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              isNri = false;
                            });
                          },
                          child: SeaTimeCalDesign(
                            isNri: isNri,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                isNri == true
                    ? NriDesign()
                    : Padding(
                        padding: const EdgeInsets.all(14.0),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            color: Colors.white,
                          ),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 8, left: 8),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 5, vertical: 5),
                                      child: Text(
                                        "Signon Date",
                                        style: GoogleFonts.roboto(
                                          fontSize: 15,
                                          color: ThemeColors
                                              .BACKGROUD_COLOR_BOTTOM,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 15),
                                      child: Text(
                                        "Signoff Date",
                                        style: GoogleFonts.roboto(
                                          fontSize: 15,
                                          color: ThemeColors
                                              .BACKGROUD_COLOR_BOTTOM,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      child: Text(
                                        "Sea Time",
                                        style: GoogleFonts.roboto(
                                          fontSize: 15,
                                          color: ThemeColors
                                              .BACKGROUD_COLOR_BOTTOM,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      child: Text(
                                        "",
                                        style: GoogleFonts.roboto(
                                          fontSize: 15,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Column(
                                children: [
                                  for (int i = 0; i < joiningDate.length; i++)
                                    DateTimeRow(
                                      joiningDateS: joiningDate[i],
                                      signOffDateS: signOffDate[i],
                                      isSeaTime: true,
                                      myVoidCallback:(){
                                        final difference = signOffDate[i].difference(joiningDate[i]).inDays + 1;
                                        total -= difference;
                                        setState(() {
                                          joiningDate.removeAt(i);
                                          signOffDate.removeAt(i);
                                        });
                                      },
                                    ),
                                ],
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 8, bottom: 8),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Sea Time in days : ${total} Days",
                                      overflow: TextOverflow.ellipsis,
                                      style: GoogleFonts.roboto(
                                          fontSize: 15,
                                          color: ThemeColors.COLORGRAY,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                "Add more calculations",
                                overflow: TextOverflow.ellipsis,
                                style: GoogleFonts.roboto(
                                  color: ThemeColors.THEME_COLOR,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 10),
                                    child: Text(
                                      "Signon Date",
                                      style: GoogleFonts.roboto(
                                        fontSize: 15,
                                        color: ThemeColors.BACKGROUD_COLOR_BOTTOM,
                                      ),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      DatePicker.showDatePicker(context,
                                          showTitleActions: true,
                                          minTime: DateTime(2000, 1, 1),
                                          maxTime: DateTime(2030, 1, 1), onChanged: (date) {
                                            setState(() {
                                              dateOne = date;
                                            });
                                          }, onConfirm: (date) {
                                            print('confirm $date');
                                          }, currentTime: DateTime.now(), locale: LocaleType.en);
                                    },
                                    child: Container(
                                      width: 130,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          width: 1,
                                          color: ThemeColors.COLOR_BORDER,
                                        ),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8, vertical: 3),
                                        child: Text(
                                          joiningDateI.toString(),
                                          style: GoogleFonts.roboto(
                                            fontSize: 15,
                                            color: ThemeColors.BACKGROUD_COLOR_BOTTOM,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 10),
                                    child: Text(
                                      "Signoff Date",
                                      style: GoogleFonts.roboto(
                                        fontSize: 15,
                                        color: ThemeColors.BACKGROUD_COLOR_BOTTOM,
                                      ),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      DatePicker.showDatePicker(context,
                                          showTitleActions: true,
                                          minTime: DateTime(2000, 1, 1),
                                          maxTime: DateTime(2030, 1, 1), onChanged: (date) {
                                            setState(() {
                                              dateTwo = date;
                                            });
                                          }, onConfirm: (date) {
                                            print('confirm $date');
                                          }, currentTime: DateTime.now(), locale: LocaleType.en);
                                    },
                                    child: Container(
                                      width: 130,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          width: 1,
                                          color: ThemeColors.COLOR_BORDER,
                                        ),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8, vertical: 3),
                                        child: Text(
                                          signOffDateI.toString(),
                                          style: GoogleFonts.roboto(
                                            fontSize: 15,
                                            color: ThemeColors.BACKGROUD_COLOR_BOTTOM,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    joiningDate.add(dateOne);
                                    signOffDate.add(dateTwo);
                                    final difference = dateTwo.difference(dateOne).inDays + 1;
                                    total += difference;
                                  });
                                },
                                child: const ButtonAddMoreCal(
                                  text: "Calculate",
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                            ],
                          ),
                        ),
                      ),
              ],
            ),
          );
        },
      ),
    );
  }
}
