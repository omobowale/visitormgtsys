import 'package:flutter/material.dart';
import 'package:vms/views/maker/appointment_location.dart';
import 'package:vms/views/wrapper.dart';

class AuthAppointmentLocation extends StatelessWidget {
  const AuthAppointmentLocation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrapper(widget: AppointmentLocation());
  }
}
