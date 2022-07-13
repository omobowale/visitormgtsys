import 'dart:convert';

import 'package:vms/models/api_response.dart';
import 'package:vms/models/appointment.dart';
import 'package:http/http.dart' as http;
import 'package:vms/models/group_head.dart';
import 'package:vms/models/room.dart';
import 'package:vms/models/user.dart';
import 'package:vms/models/visitor.dart';

class GroupHeadService {
  var url =
      "https://visitmgtsystem.fbn-devops-dev-asenv.appserviceenvironment.net/api/Frontoffice";
  var headers = {
    "Content-Type": "application/json",
  };

  Future<APIResponse<List<GroupHead>>> getGroupHeads() {
    print("i got here for group head service");

    return http.get(Uri.parse("$url/all-group-heads")).then((data) {
      print(data.statusCode);
      if (data.statusCode == 200) {
        final jsonData = json.decode(data.body);
        //convert into list of appointments
        final List<GroupHead> groupHeads = [];
        for (var item in jsonData["data"]) {
          var groupHead = GroupHead(
            staffNo: item["staffNo"],
            id: item["id"],
            staffName: item["staffName"],
            email: item["email"],
            isActive: item["isActive"],
          );
          groupHeads.add(groupHead);
        }
        print("group head data here => ${groupHeads.toString()}");
        return APIResponse<List<GroupHead>>(data: groupHeads);
      }
      return APIResponse<List<GroupHead>>(
          error: true, errorMessage: "Error fetching group heads");
    }).catchError((error) {
      print(error);
      return APIResponse<List<GroupHead>>(
          error: true, errorMessage: "Error fetching group heads");
    });
  }
}
