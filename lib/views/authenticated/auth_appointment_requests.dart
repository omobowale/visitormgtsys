import 'package:flutter/material.dart';
import 'package:vms/views/checker/appointment_requests.dart';
import 'package:vms/views/maker/visitor_information.dart';
import 'package:vms/views/wrapper.dart';

class AuthAppointmentRequests extends StatelessWidget {
  const AuthAppointmentRequests({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrapper(widget: AppointmentRequests());
  }
}
