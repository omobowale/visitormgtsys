import 'package:vms/models/appointment.dart';
import 'package:vms/models/group_head.dart';
import 'package:vms/models/host.dart';
import 'package:vms/models/room.dart';
import 'package:vms/models/visitor.dart';

class CreateAppointment {
  Appointment appointment;

  CreateAppointment({
    required this.appointment,
  });

  @override
  String toString() {
    return this.toJson().toString();
  }

  Map<String, dynamic> toJson() {
    return {
      "visit": {
        "dateAndTime": appointment.appointmentDate,
        "visitPurpose": 0,
        "visitType": appointment.appointmentStatus,
        "startTime": appointment.startTime,
        "endTime": appointment.endTime,
        "host": appointment.host.username,
        "locationId": appointment.location.id,
        "floorId": appointment.floor.id,
        "meetingRoom": appointment.meetingRoom,
        "visitors": appointment.guests,
        "groupHeadId": appointment.groupHead.id,
      }
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
    return item;
  }
}
