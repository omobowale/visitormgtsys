import 'dart:convert';
import 'package:vms/models/api_response.dart';
import 'package:http/http.dart' as http;
import 'package:vms/models/host.dart';

class HostNameService {
  var url = "https://62a9e7543b314385543df388.mockapi.io/api/v1/";
  var headers = {
    "Content-Type": "application/json",
  };

  Future<APIResponse<List<Host>>> getHosts() {
    print("i got here");
    return http.get(Uri.parse("$url/users")).then((data) {
      print(data.statusCode);
      if (data.statusCode == 200) {
        final jsonData = json.decode(data.body);
        //convert into list of appointments
        final List<Host> hosts = [];
        for (var item in jsonData) {
          print("host name item is : ${item}");
          var host = Host(
            id: item["id"],
            email: item["email"],
            username: item["username"],
          );
          hosts.add(host);
        }
        print("group head data here => ${hosts.toString()}");
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
