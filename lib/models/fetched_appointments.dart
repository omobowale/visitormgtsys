import 'package:vms/models/appointment.dart';
import 'package:vms/models/group_head.dart';
import 'package:vms/models/host.dart';
import 'package:vms/models/room.dart';
import 'package:vms/models/visitor.dart';

class FetchedAppointments {
  int appointmentId;
  String visitGuid;
  String visitPurpose;
  DateTime appointmentDate;
  DateTime startTime;
  DateTime endTime;
  String visitType;
  String appointmentStatus;
  List<dynamic> visitors;
  String location;
  String floor;
  dynamic host;
  String meetingRooms;
  dynamic groupHead;
  String cancellationReason;
  String rescheduleReason;
  String visitStatus;
  bool isCancelled;
  bool isApproved;

  FetchedAppointments({
    required this.appointmentId,
    required this.visitGuid,
    required this.visitPurpose,
    required this.appointmentDate,
    required this.startTime,
    required this.endTime,
    required this.visitType,
    required this.appointmentStatus,
    required this.visitors,
    required this.location,
    required this.floor,
    required this.host,
    required this.meetingRooms,
    required this.groupHead,
    required this.cancellationReason,
    required this.rescheduleReason,
    required this.visitStatus,
    required this.isApproved,
    required this.isCancelled,
  });

  @override
  String toString() {
    return "{appointmentId: $appointmentId, visitGuid: $visitGuid, visitPurpose: $visitPurpose, appointmentDate: $appointmentDate" +
        "startTime: $startTime, endTime: $endTime, groupHead: $groupHead, host: ${host}" +
        "}";
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
