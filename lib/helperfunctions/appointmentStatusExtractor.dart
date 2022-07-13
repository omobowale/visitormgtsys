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
