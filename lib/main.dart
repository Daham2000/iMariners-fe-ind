import 'package:com_ind_imariners/login_page/login_provider.dart';
import 'package:flutter/material.dart';
import 'theme/primary_theme.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

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
