import 'package:com_ind_imariners/login_page/counter_cubit.dart';
import 'package:com_ind_imariners/login_page/counter_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '../home_page/widget/sample_widget.dart';
import '../theme/colors.dart';
import '../widgets/app_bar_curve.dart';

class KnowlageBaseView extends StatefulWidget {
  const KnowlageBaseView({Key? key}) : super(key: key);

  @override
  _KnowlageBaseViewState createState() => _KnowlageBaseViewState();
}

class _KnowlageBaseViewState extends State<KnowlageBaseView> {
  List categoryList = [1,1,1,1,1];
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
                        for ( int i=0; i<categoryList.length; i=i+2 )
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              CategoryViewCard(),
                              CategoryViewCard(),
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
