import 'package:flutter/material.dart';
import 'package:vms/views/maker/reschedule_appointment.dart';
import 'package:vms/views/wrapper.dart';

class AuthRescheduleAppointment extends StatelessWidget {
  const AuthRescheduleAppointment({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrapper(widget: RescheduleAppointment());
  }
}
