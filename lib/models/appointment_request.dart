import 'package:vms/partials/appointment_requests/officiality_status.dart';

class AppointmentRequest {
  String staffImagePath;
  String staffName;
  String officialityStatus;
  String appointmentType;
  String date;
  String startTime;
  String endTime;
  String address;
  int noOfGuests;

  AppointmentRequest({
    required this.staffImagePath,
    required this.staffName,
    required this.officialityStatus,
    required this.appointmentType,
    required this.date,
    required this.startTime,
    required this.endTime,
    required this.address,
    required this.noOfGuests,
  });
}
