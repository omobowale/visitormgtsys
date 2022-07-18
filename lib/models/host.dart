import 'package:vms/models/group_head.dart';
import 'package:vms/models/role.dart';
import 'package:vms/models/room.dart';
import 'package:vms/models/visitor.dart';

class Host {
  int id;
  String name;
  String email;
  String staffNo;

  Host({
    required this.id,
    required this.name,
    required this.email,
    required this.staffNo,
  });

  factory Host.emptyOne() {
    return Host(id: 0, name: "", email: "", staffNo: "");
  }

  @override
  String toString() {
    return this.toJson().toString();
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "email": email,
      "staffNo": staffNo,
    };
  }

  static Host fromJson(Map<String, dynamic> host) {
    return Host(
      id: host["id"],
      name: host["name"],
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
    if (name != null && name != "") {
      return true;
    }

    return false;
  }

  bool isStrictlyValid() {
    if (email != null &&
        email != "" &&
        name != null &&
        name != "" &&
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
      name: host["name"],
      staffNo: host["staffNo"],
      id: host["id"],
    );
  }
}
