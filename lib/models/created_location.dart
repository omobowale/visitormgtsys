import 'package:provider/provider.dart';
import 'package:vms/models/floor.dart';

class CreatedLocation {
  int id;
  String meetingRoom;
  String floorName;
  int locationId;
  int floorId;

  CreatedLocation(
      {required this.meetingRoom,
      required this.id,
      required this.floorName,
      required this.floorId,
      required this.locationId});

  @override
  String toString() {
    // TODO: implement toString
    return "{meeting room: ${this.meetingRoom}, id: ${this.id}, floor name: ${this.floorName}}";
  }

  Map<String, dynamic> toMap() {
    return {"meetingRoom": meetingRoom, "id": id, "floorName": floorName};
  }

  factory CreatedLocation.emptyOne() {
    return CreatedLocation(
        meetingRoom: "", id: 0, floorName: "", floorId: 0, locationId: 0);
  }

  factory CreatedLocation.fromMap(Map<String, dynamic> location) {
    return new CreatedLocation(
      id: location["id"],
      floorName: location["floorName"],
      meetingRoom: location["meetingRoom"],
      floorId: location["floorId"],
      locationId: location["locationId"],
    );
  }

  bool isValid() {
    return meetingRoom != "" && meetingRoom != null;
  }

  static List<CreatedLocation> convertLocationMapsToLocationObjects(
      List<dynamic> locations) {
    Iterable<CreatedLocation> l = locations.map((location) {
      if (location is Map<String, dynamic>) {
        return CreatedLocation.fromMap(location);
      } else {
        return location;
      }
    });
    print("l : " + l.toString());
    return l.toList();
  }
}
