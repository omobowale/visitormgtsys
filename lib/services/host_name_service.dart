import 'dart:convert';
import 'package:vms/models/api_response.dart';
import 'package:http/http.dart' as http;
import 'package:vms/models/host.dart';

class HostNameService {
  var url =
      "https://visitmgtsystem.fbn-devops-dev-asenv.appserviceenvironment.net/api/Frontoffice";
  var headers = {
    "Content-Type": "application/json",
  };

  Future<APIResponse<List<Host>>> getHosts() {
    print("i got here");
    return http.get(Uri.parse("$url/get-all-hosts")).then((data) {
      print(data.statusCode);
      if (data.statusCode == 200) {
        final jsonData = json.decode(data.body);
        //convert into list of appointments
        final List<Host> hosts = [];
        for (var item in jsonData["data"]) {
          print("host name item is : ${item}");
          var host = Host(
            id: item["id"],
            email: item["email"],
            staffNo: item["staffNo"],
            staffName: item["staffName"],
          );
          hosts.add(host);
        }
        print("host data here => ${hosts.toString()}");
        return APIResponse<List<Host>>(data: hosts);
      }
      return APIResponse<List<Host>>(
          error: true, errorMessage: "Error fetching host names");
    }).catchError((error) {
      print(error);
      return APIResponse<List<Host>>(
          error: true, errorMessage: "Error fetching host names");
    });
  }
}
