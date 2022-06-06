import 'dart:async';
import 'package:com_ind_imariners/widgets/telegram_group.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../home_page/widget/sample_widget.dart';
import '../login_page/counter_cubit.dart';
import '../login_page/counter_state.dart';
import '../theme/colors.dart';
import '../widgets/app_bar_curve.dart';

class TelegramView extends StatefulWidget {
  const TelegramView({Key? key}) : super(key: key);

  @override
  _TelegramViewState createState() => _TelegramViewState();
}

class _TelegramViewState extends State<TelegramView> {
  @override
  void initState() {
    super.initState();
  }

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
                  text: "Telegram",
                  isContent: false,
                ),
                const SizedBox(
                  height: 25,
                ),
                Column(
                  children: [
                    GroupUI()
                  ],
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
