import 'package:vms/models/fetched_appointments.dart';
import 'package:vms/models/floor.dart';

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

List<dynamic> getRooms(List<dynamic> locations) {
  List<dynamic> rooms = [];

  locations.forEach((l) {
    rooms.add(l.meetingRoom);
  });

  return rooms;
}

String getFloorFromRoomName(List<dynamic> locations, String meetingRoom) {
  dynamic floor;
  try {
    locations.forEach((l) {
      if (l.meetingRoom == meetingRoom) {
        floor = l.floorName;
      }
    });
    return floor;
  } on Error {
    print("There was an error getting floor");
    return '';
  }
}

dynamic getLocationDetailsFromRoomName(
    List<dynamic> locations, String meetingRoom) {
  dynamic locationDetails;
  try {
    locations.forEach((l) {
      if (l.meetingRoom == meetingRoom) {
        locationDetails = l;
      }
    });
    return locationDetails;
  } on Error {
    print("There was an error getting floor");
    return {};
  }
}
