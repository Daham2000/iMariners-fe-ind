import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import '../home_page/widget/sample_widget.dart';
import '../theme/colors.dart';
import '../widgets/app_bar_curve.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as htmlparser;
import 'package:html/dom.dart' as dom;

class ContentView extends StatefulWidget {
  final List<String> link;

  const ContentView({Key? key, required this.link}) : super(key: key);

  @override
  _ContentViewState createState() => _ContentViewState();
}

class _ContentViewState extends State<ContentView> {

  String htmlCode = "";
  Widget html = Html(
    data:  """
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
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const AppBarCurve(
              text: "Navigation",
              isContent: true,
            ),
            const SizedBox(
              height: 25,
            ),
            html!=null ? html : Container()
          ],
        ),
      ),
      backgroundColor: ThemeColors.BACKGROUD_COLOR,
      bottomNavigationBar: const BottomNaviBar(),
    );
  }

  Future<void> loadHtml() async {
    final url = Uri.parse('${widget.link[0]}');
    final response = await http.get(
        url
    );
    dom.Document document = htmlparser.parse(response.body);
    setState(() {
      html = Html(
        data: response.body,
      );
    });
  }
}
