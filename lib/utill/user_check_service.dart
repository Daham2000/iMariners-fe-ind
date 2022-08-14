import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../db/models/user_model.dart';

class UserCheckService {
  Future<bool> userCheck() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? sharedUserData = prefs.getString('userObject');
      final jsonMap = json.decode(sharedUserData ?? "");
      UserModel userModel = UserModel.fromJson(jsonMap);
      if ((userModel.user?.email == "imariners@hotmail.com") ||
          userModel.user?.lastPayment != null) {
        return true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }
}
