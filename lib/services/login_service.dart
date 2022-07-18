import 'dart:convert';

import 'package:vms/constants/index.dart';
import 'package:vms/models/api_response.dart';
import 'package:http/http.dart' as http;
import 'package:vms/models/login.dart';
import 'package:vms/models/user.dart';

class LoginService {
  var url =
      "https://visitmgtsystem.fbn-devops-dev-asenv.appserviceenvironment.net/api/FrontOffice";
  var headers = {
    "Content-Type": "application/json",
  };

  Future<APIResponse<User>> login(LoginDetails login) {
    print("I am here: ${login.password}, ${login.username}");
    var body = json.encode(login.toJson(), toEncodable: login.myEncode);
    print("body ${body}");
    return http
        .post(Uri.parse("$url/login"), body: body, headers: headers)
        .then((response) {
      print("I am here too");
      print("data.statusCode ${response.statusCode}");
      print("data ${response.body}");
      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);

        var user = User(
          id: jsonData["data"]["id"],
          email: jsonData["data"]["email"],
          password: jsonData["data"]["password"],
          roles: jsonData["data"]["roles"],
          username: jsonData["data"]["username"],
          firstname: jsonData["data"]["firstName"],
          lastname: jsonData["data"]["lastName"],
          token: jsonData["token"],
        );

        print("user: ${user}");

        return APIResponse<User>(data: user, error: false);
      }
      return APIResponse<User>(
          serverError: true,
          errorMessage: "No user found. Please check credentials");
    }).catchError((error) {
      print("error here: " + error.toString());
      return APIResponse<User>(
          serverError: true,
          errorMessage: "Error fetching user. Please try again later");
    }).timeout(
      Duration(milliseconds: DELAY),
      onTimeout: () {
        return APIResponse<User>(
            data: null,
            serverError: true,
            errorMessage: "Request timed out. Please try again later");
      },
    );
  }
}
