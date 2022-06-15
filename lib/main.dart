import 'package:com_ind_imariners/login_page/login_provider.dart';
import 'package:flutter/material.dart';
import 'theme/primary_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
// Using "static" so that we can easily access it later
  static final ValueNotifier<ThemeMode> themeNotifier =
  ValueNotifier(ThemeMode.light);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'iMariners',
      theme: PrimaryTheme.generateTheme(context),
      debugShowCheckedModeBanner: false,
      home: LoginProvider(),
    );
  }
}
