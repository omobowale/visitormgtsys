import 'package:vms/models/floor.dart';

class Location {
  int id;
  String name;
  List<Floor> floors;

  Location({
    required this.name,
    required this.id,
    required this.floors,
  });

  @override
  String toString() {
    // TODO: implement toString
    return "[name: ${this.name}, id: ${this.id}, floors: ${this.floors}]";
  }

  Map<String, dynamic> toMap() {
    return {"name": name, "id": id, "floors": floors};
  }

  factory Location.emptyOne() {
    return Location(name: "", id: 0, floors: []);
  }

  factory Location.fromMap(Map<String, dynamic> location) {
    return new Location(
        id: location["id"], floors: location["floors"], name: location["name"]);
  }

  bool isValid() {
    return name != "" && name != null;
  }

  static List<Location> convertLocationMapsToLocationObjects(
      List<dynamic> locations) {
    Iterable<Location> l = locations.map((location) {
      if (location is Map<String, dynamic>) {
        return Location.fromMap(location);
      } else {
        return location;
      }
    });
    print("l : " + l.toString());
    return l.toList();
  }
}
