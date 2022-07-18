import 'package:vms/models/appointment.dart';
import 'package:vms/models/group_head.dart';
import 'package:vms/models/host.dart';
import 'package:vms/models/room.dart';
import 'package:vms/models/visitor.dart';

class RescheduleAppointment {
  int visitId;
  String rescheduleReason;
  DateTime date;
  DateTime startTime;
  DateTime endTime;

  RescheduleAppointment({
    required this.visitId,
    required this.rescheduleReason,
    required this.date,
    required this.startTime,
    required this.endTime,
  });

  @override
  String toString() {
    return this.toJson().toString();
  }

  Map<String, dynamic> toJson() {
    return {
      "visitId": visitId,
      "rescheduleReason": rescheduleReason,
      "startTime": startTime,
      "date": date,
      "endTime": endTime,
    };
  }

  dynamic myEncode(dynamic item) {
    if (item is DateTime) {
      return item.toIso8601String();
    }
    return item;
  }
}
