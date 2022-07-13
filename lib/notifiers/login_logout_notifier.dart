import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vms/data/assets.dart';
import 'package:vms/helperfunctions/enumerationExtraction.dart';
import 'package:vms/models/asset.dart';
import 'package:vms/models/group_head.dart';
import 'package:vms/models/user.dart';
import 'package:vms/notifiers/appointment_notifier.dart';
import 'package:vms/notifiers/user_notifier.dart';

class LoginLogoutNotifier with ChangeNotifier {
  bool _isLoggedIn = false;
  GroupHead gh = GroupHead.emptyOne();
  Map<String, dynamic> _allenums = {};
  User _loggedInUser = User.emptyOne();

  void set setGH(GroupHead gh) {}

  void setIsLoggedIn(bool b) {
    _isLoggedIn = b;
    notifyListeners();
  }

  void set setLoggedInUser(User user) {
    this._loggedInUser = user;
  }

  bool get isLoggedIn => _isLoggedIn;

  User get loggedInUser => _loggedInUser;

  Map<String, dynamic> get allEnums => {..._allenums};

  void set setAllEnums(Map<String, dynamic> allE) {
    _allenums = allE;
    notifyListeners();
  }

  Future<void> prepareAllConstants() async {
    getAndSetAllEnumerations().then((response) {
      setAllEnums = response;
    });
  }

  Future<void> logUserIn(User user) async {
    //set necessary variables from server
    //set enumeration
    prepareAllConstants();

    if (user != null) {
      SharedPreferences pref = await SharedPreferences.getInstance();
      String userString = jsonEncode(user.toJson());
      pref.setString('userData', userString);
      setIsLoggedIn(true);
      print("logged in user here: ${user}");
      setLoggedInUser = user;

      print("User is logged in now [${isLoggedIn}]! $userString");
      print("Logged in user details ${user}");
    }
    notifyListeners();
  }

  Future<void> logUserOut() async {
    AppointmentNotifier appointmentNotifier = AppointmentNotifier();
    SharedPreferences pref = await SharedPreferences.getInstance();

    pref.setString('userData', '');

    //set editing and creating to false
    appointmentNotifier.setIsCreating = false;
    appointmentNotifier.setIsEditing = false;

    //others
    setIsLoggedIn(false);

    notifyListeners();
  }

  Future<Map> getLoggedInUserDetails() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? userPref = pref.getString('userData');

    if (userPref != null && userPref != "") {
      Map<String, dynamic> userMap =
          jsonDecode(userPref) as Map<String, dynamic>;
      return userMap;
    }

    return {};
  }
}
