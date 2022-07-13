import 'package:vms/models/floor.dart';
import 'package:vms/models/group_head.dart';
import 'package:vms/models/host.dart';
import 'package:vms/models/location.dart';
import 'package:vms/models/room.dart';
import 'package:vms/models/visitor.dart';

class FetchAppointments {
  String id;
  int appointmentStatus;
  int visitType;
  DateTime appointmentDate;
  DateTime startTime;
  DateTime endTime;
  List<dynamic> guests;
  String accessCode;
  String qrCode;
  int floorId;
  String floor;
  String host;
  int groupHeadId;
  String meetingRoom;
  String appointmentType;
  String? purposeOfReschedule;
  String? purposeOfCancel;
  int locationId;
  String location;
  List<dynamic> rooms;

  FetchAppointments({
    required this.id,
    required this.host,
    required this.visitType,
    required this.startTime,
    required this.groupHeadId,
    required this.endTime,
    required this.appointmentType,
    required this.appointmentStatus,
    required this.appointmentDate,
    required this.floorId,
    required this.floor,
    required this.guests,
    required this.locationId,
    required this.location,
    required this.meetingRoom,
    required this.rooms,
    this.purposeOfCancel,
    this.purposeOfReschedule,
    required this.accessCode,
    required this.qrCode,
  });

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
      "floorId": floorId,
      "floor": floor,
      "meetingRoom": meetingRoom,
      "guests": guests,
      "roomNumbers": rooms,
      "location": location,
      "groupHeadId": groupHeadId,
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
