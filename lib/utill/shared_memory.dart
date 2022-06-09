import 'package:shared_preferences/shared_preferences.dart';

class SharedMemory {
  SharedPreferences? sharedPreferences;

  Future setUser(String key, String date) async {
    sharedPreferences = await SharedPreferences.getInstance();
    try {
      sharedPreferences?.setString(key, date);
    } catch (e) {
      print(e);
    }
  }

  Future<String?> getUserDetails(String key) async {
    sharedPreferences = await SharedPreferences.getInstance();
    String? user;
    try {
      user = sharedPreferences?.getString(key);
      return user;
    } catch (e) {
      print(e);
    }
    return user;
  }

  Future<void> clearAllData() async {
    sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences?.clear();
  }
}
