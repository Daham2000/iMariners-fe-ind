import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:http/http.dart' as http;
import '../main.dart';
import '../widgets/app_bar_curve.dart';
import '../widgets/drawer_app_bar.dart';

class PrivacyPolicyView extends StatefulWidget {
  const PrivacyPolicyView({Key? key}) : super(key: key);

  @override
  _PrivacyPolicyViewState createState() => _PrivacyPolicyViewState();
}

class _PrivacyPolicyViewState extends State<PrivacyPolicyView> {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      drawer: DrawerApp(
        changeTheme: changeTheme,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            AppBarCurve(
              text: "Privacy policy",
              isContent: false,
              openDrawer: openDrawer,
            ),
            const SizedBox(
              height: 25,
            ),
            html != null ? html : Container(),
          ],
        ),
      ),
    );
  }

  Future<void> loadHtml() async {
    if ("https://contents-1.s3.ap-south-1.amazonaws.com/privacy.html.txt"
        .startsWith("https://")) {
      final url = Uri.parse(
          'https://contents-1.s3.ap-south-1.amazonaws.com/privacy.html.txt');
      final response = await http.get(url);
      print(response);
      setState(() {
        html = Html(
          data: response.body,
        );
      });
    } else {
      setState(() {
        html = Html(
          data:
              'https://contents-1.s3.ap-south-1.amazonaws.com/privacy.html.txt',
        );
      });
    }
  }
}
