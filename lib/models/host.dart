import 'package:vms/models/group_head.dart';
import 'package:vms/models/role.dart';
import 'package:vms/models/room.dart';
import 'package:vms/models/visitor.dart';

class Host {
  int id;
  String staffName;
  String email;
  String staffNo;

  Host({
    required this.id,
    required this.staffName,
    required this.email,
    required this.staffNo,
  });

  factory Host.emptyOne() {
    return Host(id: 0, staffName: "", email: "", staffNo: "");
  }

  @override
  String toString() {
    return this.toJson().toString();
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "staffName": staffName,
      "email": email,
      "staffNo": staffNo,
    };
  }

  static Host fromJson(Map<String, dynamic> host) {
    return Host(
      id: host["id"],
      staffName: host["staffName"],
      email: host["email"],
      staffNo: host["staffNo"],
    );
  }

  dynamic myEncode(dynamic item) {
    if (item is Role) {
      return item;
    }

    return item;
  }

  bool isValid() {
    if (staffName != null && staffName != "") {
      return true;
    }

    return false;
  }

  bool isStrictlyValid() {
    if (email != null &&
        email != "" &&
        staffName != null &&
        staffName != "" &&
        id != "" &&
        id != "") {
      return true;
    }

    return false;
  }

  static Host fromMap(Map<String, dynamic> host) {
    print("Host " + host.toString());
    return Host(
      email: host["email"],
      staffName: host["staffName"],
      staffNo: host["staffNo"],
      id: host["id"],
    );
  }
}
