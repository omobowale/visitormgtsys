import 'package:vms/models/group_head.dart';
import 'package:vms/models/role.dart';
import 'package:vms/models/room.dart';
import 'package:vms/models/visitor.dart';

class User {
  String id;
  String password;
  String username;
  String firstname;
  String lastname;
  String email;
  String token;
  List<dynamic> roles;

  User({
    required this.id,
    required this.password,
    required this.username,
    required this.firstname,
    required this.lastname,
    required this.email,
    required this.roles,
    required this.token,
  });

  factory User.emptyOne() {
    return User(
        id: "",
        password: "",
        username: "",
        firstname: "",
        lastname: "",
        email: "",
        token: "",
        roles: []);
  }

  @override
  String toString() {
    return this.toJson().toString();
  }

  bool isValid() {
    return username != null &&
        username != "" &&
        email != null &&
        email != "" &&
        firstname != null &&
        firstname != "" &&
        lastname != null &&
        lastname != "" &&
        token != null &&
        token != "";
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "password": password,
      "username": username,
      "firstname": firstname,
      "lastname": lastname,
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
      firstname: user["firstName"],
      lastname: user["lastName"],
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
