import 'package:vms/models/group_head.dart';
import 'package:vms/models/role.dart';
import 'package:vms/models/room.dart';
import 'package:vms/models/visitor.dart';

class User {
  String id;
  String password;
  String username;
  String email;
  String token;
  List<dynamic> roles;

  User({
    required this.id,
    required this.password,
    required this.username,
    required this.email,
    required this.roles,
    required this.token,
  });

  factory User.emptyOne() {
    return User(
        id: "", password: "", username: "", email: "", token: "", roles: []);
  }

  @override
  String toString() {
    return this.toJson().toString();
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "password": password,
      "username": username,
      "roles": roles,
      "email": email,
      "token": token,
    };
  }

  static User fromJson(Map<String, dynamic> user) {
    return User(
      id: user["id"],
      password: user["password"],
      username: user["username"],
      email: user["email"],
      roles: user["roles"],
      token: user["token"],
    );
  }

  dynamic myEncode(dynamic item) {
    if (item is Role) {
      return item;
    }

    return item;
  }
}
