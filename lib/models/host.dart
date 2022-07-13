import 'package:vms/models/group_head.dart';
import 'package:vms/models/role.dart';
import 'package:vms/models/room.dart';
import 'package:vms/models/visitor.dart';

class Host {
  String id;
  String username;
  String email;

  Host({
    required this.id,
    required this.username,
    required this.email,
  });

  factory Host.emptyOne() {
    return Host(
      id: "",
      username: "",
      email: "",
    );
  }

  @override
  String toString() {
    return this.toJson().toString();
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "username": username,
      "email": email,
    };
  }

  static Host fromJson(Map<String, dynamic> host) {
    return Host(
      id: host["id"],
      username: host["username"],
      email: host["email"],
    );
  }

  dynamic myEncode(dynamic item) {
    if (item is Role) {
      return item;
    }

    return item;
  }

  bool isValid() {
    if (username != null && username != "") {
      return true;
    }

    return false;
  }

  bool isStrictlyValid() {
    if (email != null &&
        email != "" &&
        username != null &&
        username != "" &&
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
      username: host["username"],
      id: host["id"],
    );
  }
}
