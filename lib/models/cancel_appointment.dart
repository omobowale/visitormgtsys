import 'package:vms/models/appointment.dart';
import 'package:vms/models/group_head.dart';
import 'package:vms/models/host.dart';
import 'package:vms/models/room.dart';
import 'package:vms/models/visitor.dart';

class CancelAppointment {
  int visitId;
  String reason;

  CancelAppointment({
    required this.visitId,
    required this.reason,
  });

  @override
  String toString() {
    return this.toJson().toString();
  }

  Map<String, dynamic> toJson() {
    return {
      "visitId": visitId,
      "reason": reason,
    };
  }

  dynamic myEncode(dynamic item) {
    return item;
  }
}
