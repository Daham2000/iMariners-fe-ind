import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import '../home_page/widget/sample_widget.dart';
import '../main.dart';
import '../theme/colors.dart';
import '../widgets/app_bar_curve.dart';
import 'package:http/http.dart' as http;

class ContentView extends StatefulWidget {
  final String name;
  final List<String> link;

  const ContentView({Key? key, required this.link, required this.name})
      : super(key: key);

  @override
  _ContentViewState createState() => _ContentViewState();
}

class _ContentViewState extends State<ContentView> {
  String htmlCode = "";
  Widget html = Html(
    data: """
  <h3>Loading the content please wait</h3>
  """,
  );

  @override
  void initState() {
    loadHtml();
    super.initState();
  }

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
    return Scaffold(
      key: _key,
      backgroundColor: MyApp.themeNotifier.value == ThemeMode.light
          ? ThemeColors.BACKGROUD_COLOR
          : Colors.grey,
      drawer: DrawerApp(
        changeTheme: changeTheme,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AppBarCurve(
              text: widget.name,
              isContent: true,
              openDrawer: openDrawer,
            ),
            const SizedBox(
              height: 25,
            ),
            html != null ? html : Container()
          ],
        ),
      ),
      // bottomNavigationBar: const BottomNaviBar(),
    );
  }

  Future<void> loadHtml() async {
    if (widget.link[0].startsWith("https://")) {
      final url = Uri.parse('${widget.link[0]}');
      final response = await http.get(url);
      setState(() {
        html = Html(
          data: response.body,
        );
      });
    } else {
      setState(() {
        html = Html(
          data: widget.link[0],
        );
      });
    }
  }
}
