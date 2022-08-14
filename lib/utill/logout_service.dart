import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../db/api/auth_api.dart';
import '../db/models/user_model.dart';

class LogoutService{
  Future<bool> logout() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? s = prefs.getString('userObject');
      Map<String, dynamic> userMap = jsonDecode(s ?? "");
      final user = UserModel.fromJson(userMap);
      final int status = await AuthApi().logout(user.user?.id);
      if (status == 200) {
        return true;
      }
      return false;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }
}