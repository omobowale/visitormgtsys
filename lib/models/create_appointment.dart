import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:vms/helperfunctions/enumerationExtraction.dart';
import 'package:vms/models/appointment.dart';
import 'package:vms/models/group_head.dart';
import 'package:vms/models/host.dart';
import 'package:vms/models/room.dart';
import 'package:vms/models/visitor.dart';
import 'package:vms/notifiers/login_logout_notifier.dart';

class CreateAppointment {
  Appointment appointment;

  CreateAppointment({
    required this.appointment,
  });

  Map<String, dynamic> toJson(BuildContext context) {
    print("massive extraction");
    var allenums = context.read<LoginLogoutNotifier>().allEnums;
    print("all our enums here ${allenums}");

    var visitPurposeId = getEnumByName(
            getAndSetEnumeration(allenums, "purposeEnum"),
            appointment.visitPurpose)["id"] ??
        0;
    var visitTypeId = getEnumByName(
            getAndSetEnumeration(allenums, "visitTypeEnum"),
            appointment.visitType)["id"] ??
        0;

    var newVisitors = appointment.guests.map((e) {
      var val = getEnumByName(getAndSetEnumeration(allenums, "visitorTypeEnum"),
              appointment.visitorType)["id"] ??
          0;
      e.visitorType = val;
      return e;
    });

    return {
      "visit": {
        "dateAndTime": appointment.appointmentDate,
        "visitPurpose": int.tryParse(visitPurposeId) ?? 0,
        "visitType": visitTypeId,
        "startTime": appointment.startTime,
        "endTime": appointment.endTime,
        "host": appointment.host.staffName,
        "locationId": appointment.locationId,
        "floorId": appointment.floorId,
        "meetingRooms": appointment.meetingRoom,
        "visitors": newVisitors.toList(),
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
