import 'package:com_ind_imariners/db/models/category_model.dart';
import 'package:com_ind_imariners/login_page/counter_cubit.dart';
import 'package:com_ind_imariners/login_page/counter_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '../home_page/widget/sample_widget.dart';
import '../theme/colors.dart';
import '../widgets/app_bar_curve.dart';

class KnowlageBaseView extends StatefulWidget {
  CategoryModel categoryModel;

  KnowlageBaseView({Key? key, required this.categoryModel});

  @override
  _KnowlageBaseViewState createState() => _KnowlageBaseViewState();
}

class _KnowlageBaseViewState extends State<KnowlageBaseView> {

  final GlobalKey<ScaffoldState> _key = GlobalKey(); // Create a key

  void openDrawer() {
    _key.currentState!.openDrawer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      drawer: DrawerApp(),
      body: BlocBuilder<CounterCubit, CounterState>(
        buildWhen: (pre, current) => pre.count != current.count,
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
                const TopicHomePage(),
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
                        for (int i = 0;
                            i < widget.categoryModel.data!.length;
                            i = i + 2)
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CategoryViewCard(
                                datum: widget.categoryModel.data![i],
                              ),
                              widget.categoryModel.data!.length > 2
                                  ? CategoryViewCard(
                                      datum: widget.categoryModel.data![i + 1])
                                  : Container(),
                            ],
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
