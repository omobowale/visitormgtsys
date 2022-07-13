import 'package:flutter/material.dart';
import 'package:vms/data/appointment_statuses.dart';
import 'package:vms/data/visit_types.dart';
import 'package:vms/models/appointment_status.dart';
import 'package:vms/models/visit_type.dart';

class AppointmentStatusNotifier with ChangeNotifier {
  List<AppointmentStatus> get allOfficialityTypes {
    return createAppointmentStatusesFromData(appointmentStatuses);
  }

  List<AppointmentStatus> createAppointmentStatusesFromData(
      List<dynamic> appointmentStatuses) {
    int count = 0;
    List<AppointmentStatus> allAppoointmentStatuses =
        appointmentStatuses.map((appointmentStatus) {
      count++;
      return AppointmentStatus(
        id: (count).toString(),
        type: appointmentStatus,
        value: (count - 1 >= 0 ? count - 1 : count),
      );
    }).toList();

    return allAppoointmentStatuses;
  }
}
