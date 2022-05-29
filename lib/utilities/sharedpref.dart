import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:viking_game/models/vuser.dart';
import 'package:viking_game/utilities/constants.dart';
import 'package:viking_game/utilities/enums.dart';

class SharedPrefrencesHelper {
  static Future<SharedPreferences> getSharedInstance() async {
    return await SharedPreferences.getInstance();
  }

  static Future<String?> getToken() async {
    final SharedPreferences prefs = await getSharedInstance();
    return prefs.getString(SharedKeys.token);
  }

  static setToken(String token) async {
    final SharedPreferences prefs = await getSharedInstance();
    await prefs.setString(SharedKeys.token, token);
  }

  static setUserInfo(VUser user) async {
    final SharedPreferences prefs = await getSharedInstance();
    await prefs.setString(SharedKeys.user, jsonEncode(user));
  }

  static Future<VUser> getUserInfo() async {
    final SharedPreferences prefs = await getSharedInstance();
    var userInfo = json.decode(prefs.getString(SharedKeys.user).toString());
    return VUser.fromJson(userInfo);
  }

  static setSessionTime(int sessionTime) async {
    final SharedPreferences prefs = await getSharedInstance();
    await prefs.setInt(SharedKeys.sessionTime, sessionTime);
  }

  static Future<int> getSessionTime() async {
    final SharedPreferences prefs = await getSharedInstance();
    int? sessionTime = prefs.getInt(SharedKeys.sessionTime);
    return sessionTime!;
  }

  static signOut() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove(SharedKeys.token);
    prefs.remove(SharedKeys.user);
    prefs.remove(SharedKeys.sessionTime);
  }
}
