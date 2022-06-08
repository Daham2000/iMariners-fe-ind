import 'dart:convert';

import 'package:com_ind_imariners/db/models/user_model.dart';
import 'package:com_ind_imariners/utill/strings.dart';
import 'package:http/http.dart' as http;

class AuthApi {
  Future<int> login(User user, String role) async {
    try {
      final body = {
        "email": user.email,
        "role": role,
        "deviceId": user.deviceId,
        "lastLogin": user.lastLogin,
        "password": user.password
      };
      final url = Uri.parse('${Strings.url}v1/user/sign-in');
      final response = await http.post(url,
          headers: {"Content-Type": "application/json"}, body: json.encode(body));
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');
      return response.statusCode;
    } catch (e) {
      print(e.toString());
      return 401;
    }
  }

  Future<bool> register(User user) async {
    try {
      final body = {
        "email": user.email,
        "username": user.username,
        "deviceId": user.deviceId,
        "password": user.password
      };
      final url = Uri.parse('${Strings.url}/v1/user/sign-up');
      final response = await http.post(url, body: body);
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e.toString());
      return false;
    }
  }
}
