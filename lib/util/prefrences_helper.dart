import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../data/models/user_model.dart';

class PrefHelper {
  static Future<void> saveUsersInfo(UserModel user) async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey('userInfo')) {
      prefs.remove("userInfo");
    }
    final userInfo = jsonEncode(user.toMap());
    prefs.setString('userInfo', userInfo);
  }

  static Future<UserModel> getSavedInfo() async {
    final prefs = await SharedPreferences.getInstance();
    final userMap =
        json.decode(prefs.getString('userInfo')!) as Map<String, dynamic>;
    final user = UserModel.fromMap(userMap);
    return user;
  }
}
