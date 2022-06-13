import 'package:com_ind_imariners/widgets/telegram_group.dart';
import 'package:flutter/material.dart';
import '../db/api/category_api.dart';
import '../db/models/telegramModel.dart';
import '../home_page/widget/sample_widget.dart';
import '../theme/colors.dart';
import '../widgets/app_bar_curve.dart';

class TelegramView extends StatefulWidget {
  const TelegramView({Key? key}) : super(key: key);

  @override
  _TelegramViewState createState() => _TelegramViewState();
}

class _TelegramViewState extends State<TelegramView> {
  TelegramModel telegramModel = TelegramModel(groups: []);
  bool loading = false;

  @override
  void initState() {
    loadGroups();
    super.initState();
  }

  Future<void> loadGroups() async {
    setState(() {
      loading = true;
    });
    final c = await CategoryAPI().getGroups();
    setState(() {
      telegramModel = c;
      loading = false;
    });
  }

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
                    text: "Telegram",
                    openDrawer: openDrawer,
                    isContent: false,
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  loading
                      ? Center(child: CircularProgressIndicator())
                      : Column(
                    children: [
                      for (int i = 0; i < telegramModel.groups!.length; i++)
                        GroupUI(
                          name: telegramModel.groups![i].name,
                          link: telegramModel.groups![i].link,
                        ),
                    ],
                  )
                ],
              ),
      ),
      backgroundColor: ThemeColors.BACKGROUD_COLOR,
      bottomNavigationBar: const BottomNaviBar(),
    );
  }
}
