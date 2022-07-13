import 'package:flutter/cupertino.dart';
import 'package:vms/data/rooms.dart';
import 'package:vms/models/group_head.dart';
import 'package:vms/models/room.dart';
import 'package:vms/models/user.dart';
import 'package:vms/notifiers/login_logout_notifier.dart';

class UserNotifier with ChangeNotifier {
  LoginLogoutNotifier loginLogoutNotifier = LoginLogoutNotifier();
  List<dynamic> userRoles = [];
  final GH_ROLE = "GroupHead";
  bool userIsGH = false;
  String ghId = "";
  GroupHead gh = GroupHead.emptyOne();

  void set setUserRoles(List<dynamic> roles) {
    userRoles = roles;
    notifyListeners();
  }

  bool get isUserGH => userIsGH;

  void set setUserIsGH(bool isGH) {
    userIsGH = isGH;
    notifyListeners();
  }

  void set setGh(GroupHead gh) {
    gh = gh;
    notifyListeners();
  }

  void set setGhId(String ghId) {
    ghId = ghId;
    notifyListeners();
  }

  Future<List<dynamic>> getAndSetUserRoles() async {
    Map<dynamic, dynamic> userDetails =
        await loginLogoutNotifier.getLoggedInUserDetails();
    User user = User.fromJson(userDetails as Map<String, dynamic>);
    if (user != null) {
      print("user from getandsetuserroles: ${user}");
      setUserRoles = user.roles;
      setUserIsGH = isGH();
      setGhId = getGHId();
      return user.roles;
    }

    return [];
  }

  bool isGH() {
    print("checking if GH ${userRoles}");

    try {
      var role = userRoles
          .firstWhere((element) => element["name"].toString() == GH_ROLE);
      print("returned role: " + role.toString());
      if (role != null && role.isNotEmpty) {
        return true;
      }
      return false;
    } on StateError {
      print("an error occured checking if user is GH");
      return false;
    }
  }

  String getGHId() {
    try {
      var role = userRoles.firstWhere((element) => element["name"] == GH_ROLE);
      print("returned role: " + role.toString());
      if (role != null && role.isNotEmpty) {
        return role["id"];
      }
      return "";
    } on StateError {
      return "";
    }
  }
}
