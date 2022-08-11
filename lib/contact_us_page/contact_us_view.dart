import 'package:com_ind_imariners/db/api/auth_api.dart';
import 'package:flutter/material.dart';

import '../main.dart';
import '../widgets/app_bar_curve.dart';
import '../widgets/drawer_app_bar.dart';
import '../widgets/snackbar_factory.dart';

class ContactUsPage extends StatefulWidget {
  const ContactUsPage({Key? key}) : super(key: key);

  @override
  _ContactUsPageState createState() => _ContactUsPageState();
}

class _ContactUsPageState extends State<ContactUsPage> {
  final GlobalKey<ScaffoldState> _key = GlobalKey(); // Create a key
  final TextEditingController subjectCtrl = TextEditingController();
  final TextEditingController messageCtrl = TextEditingController();

  void changeTheme() {
    setState(() {
      MyApp.themeNotifier.value = MyApp.themeNotifier.value == ThemeMode.light
          ? ThemeMode.dark
          : ThemeMode.light;
    });
  }

  void openDrawer() {
    _key.currentState!.openDrawer();
  }

  TextFormField getSearchTextField(TextEditingController ctrl, String hint) {
    return TextFormField(
      controller: ctrl,
      cursorColor: Colors.black,
      maxLines: hint == "Enter message" ? 3 : 1,
      decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            // width: 0.0 produces a thin "hairline" border
            borderSide: const BorderSide(color: Colors.grey, width: 0.5),
            borderRadius: hint == "Enter message"
                ? BorderRadius.circular(10.0)
                : BorderRadius.circular(50.0),
          ),
          hintStyle: TextStyle(color: Colors.grey[400]),
          hintText: hint,
          fillColor: Colors.white70),
    );
  }

  @override
  Widget build(BuildContext context) {
    final fontSize = MediaQuery.of(context).textScaleFactor;
    return Scaffold(
      key: _key,
      drawer: DrawerApp(
        changeTheme: changeTheme,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            AppBarCurve(
              text: "Contact us",
              isContent: false,
              openDrawer: openDrawer,
            ),
            const SizedBox(
              height: 40,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: getSearchTextField(subjectCtrl, "Enter subject"),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: getSearchTextField(messageCtrl, "Enter message"),
            ),
            ElevatedButton(
              onPressed: () async {
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBarFactory().getSnackBar(
                  isFail: false,
                  title: "Request sending...",
                  fontSize: fontSize,
                ));
                //check if fields are empty
                //if empty show message
                if (subjectCtrl.text.isEmpty) {
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBarFactory().getSnackBar(
                    isFail: true,
                    title: "Subject field shouldn't be empty",
                    fontSize: fontSize,
                  ));
                }
                if (messageCtrl.text.isEmpty) {
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBarFactory().getSnackBar(
                    isFail: true,
                    title: "Message field shouldn't be empty",
                    fontSize: fontSize,
                  ));
                }
                //if not send the message to backend
                //if success show message
                else {
                  final int statusCode = await AuthApi()
                      .contactUs(subjectCtrl.text, messageCtrl.text);
                  if (statusCode == 200) {
                    ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBarFactory().getSnackBar(
                      isFail: false,
                      title: "Request sent, we will get back to you soon.",
                      fontSize: fontSize,
                    ));
                  }
                }
              },
              child: const Text("Submit request"),
            ),
          ],
        ),
      ),
    );
  }
}
