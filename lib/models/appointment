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
  String visitPurpose;
  String visitorType;
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

  // {
  // "data": {
  //   "purposeEnum": {
  //     "0": "Official",
  //     "1": "Personal"
  //   },
  //   "visitTypeEnum": {
  //     "0": "Individual",
  //     "1": "Group"
  //   },
  //   "visitStatusEnum": {
  //     "0": "Pending",
  //     "1": "Approved",
  //     "2": "Declined",
  //     "3": "Cancelled",
  //     "4": "Rescheduled"
  //   },
  //   "assetTypeEnum": {
  //     "0": "Laptop",
  //     "1": "iPad",
  //     "2": "Others"
  //   },
  //   "visitorTypeEnum": {
  //     "0": "Regular",
  //     "1": "VVIP"
  //   },
  //   "appointmentStatusEnum": {
  //     "0": "Active",
  //     "1": "Closed"
  //   },
  //   "çancellationReasonEnum": {
  //     "0": "Unable_to_get_Time_off",
  //     "1": "Out_of_office",
  //     "2": "Insecurity",
  //     "3": "Inconvienent",
  //     "4": "Others"
  //   }

  Appointment({
    required this.id,
    required this.host,
    required this.visitType,
    required this.startTime,
    required this.groupHead,
    required this.endTime,
    required this.appointmentStatus,
    required this.appointmentDate,
    required this.visitPurpose,
    required this.visitorType,
    required this.floor,
    required this.guests,
    required this.meetingRoom,
    required this.rooms,
    required this.location,
    this.purposeOfCancel,
    this.purposeOfReschedule,
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
      "visitPurpose": visitPurpose,
      "startTime": startTime,
      "endTime": endTime,
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
