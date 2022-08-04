import 'dart:convert';
import 'dart:developer';
import 'package:cancer_free/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/doctor.dart';

class SessionPreferencesServices {
  static Future<SharedPreferences> _initSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs;
  }

  Future<void> setUserSession({required UserModel userSession}) async {
    SharedPreferences prefs = await _initSharedPreferences();
    prefs.setString('usersession', jsonEncode(userSession.toAddJson()));
  }

  Future<bool> clearUserSession() async {
    SharedPreferences prefs = await _initSharedPreferences();
    return prefs.remove('usersession');
  }

  Future<dynamic> getUserSession() async {
    SharedPreferences prefs = await _initSharedPreferences();
    String? sessionString = prefs.getString('usersession');
    if (sessionString != null) {
      UserModel session = UserModel.fromJson(jsonDecode(sessionString));
      return session;
    } else {
      return null;
    }
  }

  Future<void> setDoctorSession({required DoctorModel userSession}) async {
    SharedPreferences prefs = await _initSharedPreferences();
    prefs.setString('doctorsession', jsonEncode(userSession));
  }

  Future<bool> clearDoctorSession() async {
    SharedPreferences prefs = await _initSharedPreferences();
    return prefs.remove('doctorsession');
  }

  Future<dynamic> getDoctorSession() async {
    SharedPreferences prefs = await _initSharedPreferences();
    String? sessionString = prefs.getString('doctorsession');
    log('doctor Session :$sessionString');
    if (sessionString != null) {
      DoctorModel session = DoctorModel.fromJson(jsonDecode(sessionString));
      return session;
    } else {
      return null;
    }
  }
}
