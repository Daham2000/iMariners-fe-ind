import 'dart:convert';

import 'package:com_ind_imariners/db/models/user_model.dart';
import 'package:com_ind_imariners/utill/strings.dart';
import 'package:http/http.dart' as http;

class AuthApi {
  Future<int> login(User user, String role) async {
    UserModel userModel;
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
          headers: {"Content-Type": "application/json"},
          body: json.encode(body));
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');
      if (response.statusCode == 200) {
        final jsonString = response.body;
        final jsonMap = json.decode(jsonString);
        userModel = UserModel.fromJson(jsonMap);
      }
      return response.statusCode;
    } catch (e) {
      print(e.toString());
      return 401;
    }
  }

  Future<int> register(User user) async {
    try {
      final body = {
        "email": user.email,
        "username": user.username,
        "deviceId": user.deviceId,
        "password": user.password
      };
      final url = Uri.parse('${Strings.url}v1/user/sign-up');
      final response = await http.post(url,
          headers: {"Content-Type": "application/json"},
          body: json.encode(body));
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');
      return response.statusCode;
    } catch (e) {
      print(e.toString());
      return 401;
    }
  }

  Future<int> resetPasswordEmail(User user) async {
    try {
      final body = {
        "email": user.email,
      };
      final url = Uri.parse('${Strings.url}v1/user/resetpassword');
      final response = await http.post(url,
          headers: {"Content-Type": "application/json"},
          body: json.encode(body));
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');
      return response.statusCode;
    } catch (e) {
      print(e.toString());
      return 401;
    }
  }

  Future<int> resetDeviceEmail(User user) async {
    try {
      final body = {
        "email": user.email,
      };
      final url = Uri.parse('${Strings.url}v1/user/reset-device');
      final response = await http.post(url,
          headers: {"Content-Type": "application/json"},
          body: json.encode(body));
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');
      return response.statusCode;
    } catch (e) {
      print(e.toString());
      return 401;
    }
  }

  Future<int> checkCode(String email, String code) async {
    print(email);
    print(code);
    try {
      final body = {
        "email": email,
        "token": code,
      };
      final url = Uri.parse('${Strings.url}v1/user/checktoken');
      final response = await http.patch(url,
          headers: {"Content-Type": "application/json"},
          body: json.encode(body));
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');
      return response.statusCode;
    } catch (e) {
      print(e.toString());
      return 401;
    }
  }

  Future<int> changePassword(String email, String password) async {
    print("changePassword");
    try {
      final body = {
        "email": email,
        "password": password,
      };
      final url = Uri.parse('${Strings.url}v1/user/changepassword');
      final response = await http.patch(url,
          headers: {"Content-Type": "application/json"},
          body: json.encode(body));
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');
      return response.statusCode;
    } catch (e) {
      print(e.toString());
      return 401;
    }
  }
}
