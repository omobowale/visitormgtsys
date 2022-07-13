import 'package:flutter/material.dart';
import 'package:vms/custom_classes/palette.dart';

var appointmentStatuses = Set.from([
  // {"name": "Pending", "id": "1", "value": 0},
  // {"name": "Approved", "id": "2", "value": 1},
  // {"name": "Denied", "id": "3", "value": 2},
]).toList();

dynamic getAppointmentNameFromValue(int value) {
  if (value >= 0 || value < appointmentStatuses.length) {
    return appointmentStatuses.firstWhere((e) => e["value"] == value)["name"];
  }

  return "";
}
