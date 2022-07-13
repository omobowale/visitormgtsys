import 'dart:convert';

import 'package:vms/models/api_response.dart';
import 'package:http/http.dart' as http;
import 'package:vms/models/enumeration.dart';
import 'package:vms/models/floor.dart';
import 'package:vms/models/location.dart';

class LocationService {
  var url =
      "https://visitmgtsystem.fbn-devops-dev-asenv.appserviceenvironment.net/api/Frontoffice";
  var headers = {
    "Content-Type": "application/json",
  };

  Future<APIResponse<List<Location>>> getLocations() {
    return http.get(Uri.parse("$url/all-locations")).then((data) {
      if (data.statusCode == 200) {
        final jsonData = json.decode(data.body);
        print("json data: " + jsonData["data"].toString());
        final List<Location> locations = [];
        for (var item in jsonData["data"]) {
          var location = Location(
            id: item["id"],
            name: item["name"],
            floors: Floor.convertFloorMapsToFloorObjects(item["floors"]),
          );
          locations.add(location);
        }

        print("locations ${locations}");

        return APIResponse<List<Location>>(data: locations);
      }
      return APIResponse<List<Location>>(
          error: true, errorMessage: "Error fetching locations");
    }).catchError((error) {
      print("error here: " + error.toString());
      return APIResponse<List<Location>>(
          error: true, errorMessage: "Error fetching locations");
    });
  }
}
