import 'package:vms/models/fetched_appointments.dart';

Map<String, dynamic> selectedAppointmentStatusEnum(
    int appointmentStatus, List<Map<String, dynamic>> statuses) {
  try {
    var as = statuses.firstWhere((status) {
      return status["id"] == appointmentStatus.toString();
    });
    if (as.isNotEmpty) {
      return as;
    }
    return {};
  } on StateError {
    return {};
  }
}

bool canBeApproved(int appointmentStatus, List<Map<String, dynamic>> statuses) {
  var x = selectedAppointmentStatusEnum(appointmentStatus, statuses);
  if (x.isNotEmpty) {
    if (x["name"].toLowerCase() == "pending") {
      return true;
    }

    return false;
  }
  return false;
}

String getVisitorType(FetchedAppointments? fetchedAppointment) {
  if (fetchedAppointment!.visitors != null) {
    try {
      return fetchedAppointment.visitors[0].visitorType;
    } on RangeError {
      return "-";
    }
  }

  return '-';
}
