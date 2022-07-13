import 'package:vms/models/room.dart';

class Floor {
  String name;
  int id;
  int locationId;
  List<dynamic> meetingRooms;

  Floor(
      {required this.name,
      required this.id,
      required this.locationId,
      required this.meetingRooms});

  @override
  String toString() {
    // TODO: implement toString
    return "[name: ${this.name}, id: ${this.id}, locationId: ${this.locationId}, rooms: ${this.meetingRooms}]";
  }

  Map<String, dynamic> toMap() {
    return {
      "name": name,
      "id": id,
      "locationId": locationId,
      "rooms": meetingRooms
    };
  }

  bool isValid() {
    return name != "" && name != null;
  }

  factory Floor.emptyOne() {
    return Floor(name: "", id: 0, locationId: 0, meetingRooms: []);
  }

  factory Floor.fromMap(Map<String, dynamic> floor) {
    return new Floor(
        locationId: floor["locationId"],
        id: floor["id"],
        meetingRooms: floor["meetingRooms"],
        name: floor["name"]);
  }

  static List<Floor> convertFloorMapsToFloorObjects(List<dynamic> floors) {
    Iterable<Floor> f = floors.map((floor) {
      if (floor is Map<String, dynamic>) {
        return Floor.fromMap(floor);
      } else {
        return floor;
      }
    });
    print("f : " + f.toString());
    return f.toList();
  }
}
