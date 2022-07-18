import 'package:vms/models/appointment.dart';
import 'package:vms/models/group_head.dart';
import 'package:vms/models/host.dart';
import 'package:vms/models/room.dart';
import 'package:vms/models/visitor.dart';

class ApproveAppointment {
  int visitId;

  ApproveAppointment({
    required this.visitId,
  });

  @override
  String toString() {
    return this.toJson().toString();
  }

  Map<String, dynamic> toJson() {
    return {
      "visitId": visitId,
    };
  }

  dynamic myEncode(dynamic item) {
    return item;
  }
}
