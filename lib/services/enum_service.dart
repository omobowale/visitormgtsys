import 'dart:convert';

import 'package:vms/models/api_response.dart';
import 'package:http/http.dart' as http;
import 'package:vms/models/enumeration.dart';

class EnumService {
  var url =
      "https://visitmgtsystem.fbn-devops-dev-asenv.appserviceenvironment.net/api/Frontoffice/";
  var headers = {
    "Content-Type": "application/json",
  };

  Future<APIResponse<List<Enumeration>>> getEnumerations() {
    return http.get(Uri.parse("$url/all-enums")).then((data) {
      print("I got here for enums 2");
      print("data.statusCode: ${data.statusCode}");
      if (data.statusCode == 200) {
        final jsonData = json.decode(data.body);
        print("json data: " + jsonData.toString());
        final List<Enumeration> enumerations = [];

        var enumeration = Enumeration(
          enums: jsonData["data"],
        );
        enumerations.add(enumeration);

        print("enums ${enumerations}");

        return APIResponse<List<Enumeration>>(data: enumerations);
      }
      return APIResponse<List<Enumeration>>(
          error: true, errorMessage: "Error fetching enumerations");
    }).catchError((error) {
      print("error here: " + error.toString());
      return APIResponse<List<Enumeration>>(
          error: true, errorMessage: "Error fetching enumerations");
    });
  }
}
