import 'package:vms/models/floor.dart';
import 'package:vms/models/group_head.dart';
import 'package:vms/models/host.dart';
import 'package:vms/models/location.dart';
import 'package:vms/models/room.dart';
import 'package:vms/models/visitor.dart';

class Appointment {
  String id;
  Host host;
  Location location;
  String visitType;
  String appointmentType;
  DateTime startTime;
  DateTime endTime;
  DateTime appointmentDate;
  int appointmentStatus;
  String meetingRoom;
  List<dynamic> guests;
  Floor floor;
  List<dynamic> rooms;
  GroupHead groupHead;
  String? purposeOfReschedule;
  String? purposeOfCancel;

  Appointment(
      {required this.id,
      required this.host,
      required this.visitType,
      required this.startTime,
      required this.groupHead,
      required this.endTime,
      required this.appointmentType,
      required this.appointmentStatus,
      required this.appointmentDate,
      required this.floor,
      required this.guests,
      required this.meetingRoom,
      required this.rooms,
      required this.location,
      this.purposeOfCancel,
      this.purposeOfReschedule});

  void set setStartTime(DateTime time) {
    this.startTime = time;
  }

  void set setEndTime(DateTime time) {
    this.endTime = time;
  }

  void set setAppointmentDate(DateTime date) {
    this.appointmentDate = date;
  }

  @override
  String toString() {
    return this.toJson().toString();
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "host": host,
      "visitType": visitType,
      "startTime": startTime,
      "endTime": endTime,
      "appointmentType": appointmentType,
      "appointmentStatus": appointmentStatus,
      "appointmentDate": appointmentDate,
      "floorNumber": floor,
      "meetingRoom": meetingRoom,
      "guests": guests,
      "roomNumbers": rooms,
      "location": location,
      "groupHead": groupHead,
      "purposeOfCancel": purposeOfCancel,
      "purposeOfReschedule": purposeOfReschedule,
    };
  }

  dynamic myEncode(dynamic item) {
    if (item is DateTime) {
      return item.toIso8601String();
    }
    if (item is Visitor) {
      return item.toMap();
    }
    if (item is Room) {
      return item.toMap();
    }
    if (item is GroupHead) {
      return item.toMap();
    }
    if (item is Host) {
      return item.toJson();
    }
    if (item is Location) {
      return item.toMap();
    }
    if (item is Floor) {
      return item.toMap();
    }
    return item;
  }
}
