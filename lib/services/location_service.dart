import 'dart:convert';

import 'package:vms/models/api_response.dart';
import 'package:http/http.dart' as http;
import 'package:vms/models/created_location.dart';
import 'package:vms/models/enumeration.dart';
import 'package:vms/models/floor.dart';
import 'package:vms/models/location.dart';

class LocationService {
  var url =
      "https://visitmgtsystem.fbn-devops-dev-asenv.appserviceenvironment.net/api/Frontoffice";
  var headers = {
    "Content-Type": "application/json",
  };

  Future<APIResponse<List<CreatedLocation>>> getLocations() {
    return http.get(Uri.parse("$url/all-locations")).then((data) {
      if (data.statusCode == 200) {
        final jsonData = json.decode(data.body);

        final List<CreatedLocation> locations = [];
        for (var item in jsonData["data"]) {
          var location = CreatedLocation(
            id: item["id"],
            meetingRoom: item["meetingRoom"],
            floorName: item["floorName"],
            locationId: item["locationId"],
            floorId: item["floorId"],
          );
          locations.add(location);
        }

        return APIResponse<List<CreatedLocation>>(data: locations);
      }
      return APIResponse<List<CreatedLocation>>(
          error: true, errorMessage: "Error fetching locations");
    }).catchError((error) {
      print("error here: " + error.toString());
      return APIResponse<List<CreatedLocation>>(
          error: true, errorMessage: "Error fetching locations");
    });
  }
}
