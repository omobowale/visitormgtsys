import 'package:flutter/material.dart';

class GroupHead with ChangeNotifier {
  int id;
  String staffName;
  String email;
  String staffNo;
  bool isActive;

  GroupHead({
    required this.id,
    required this.staffNo,
    required this.staffName,
    required this.email,
    required this.isActive,
  });

  factory GroupHead.emptyOne() {
    return GroupHead(
        id: 0, staffNo: "", staffName: "", email: "", isActive: false);
  }

  bool isValid() {
    return notEmptyAndNull(staffName) &&
        notEmptyAndNull(staffNo) &&
        notEmptyAndNull(id.toString());
  }

  bool isStrictlyValid() {
    return notEmptyAndNull(email) &&
        notEmptyAndNull(staffName) &&
        notEmptyAndNull(staffNo) &&
        notEmptyAndNull(id.toString());
  }

  bool notEmptyAndNull(String str) {
    return str != "" && str != null;
  }

  @override
  String toString() {
    return "[staffNo: $staffNo, staffName: $staffName, id: $id,  email: $email, isActive: $isActive]";
  }

  Map<String, dynamic> toMap() {
    return {
      "staffName": staffName,
      "id": id,
      "email": email,
      "staffNo": staffNo,
      "isActive": isActive,
    };
  }

  static GroupHead fromMap(Map<String, dynamic> groupHead) {
    print("Group head " + groupHead.toString());
    return GroupHead(
      email: groupHead["email"],
      staffName: groupHead["staffName"],
      id: groupHead["id"],
      staffNo: groupHead["staffNo"],
      isActive: groupHead["isActive"],
    );
  }
}
