import 'package:flutter/material.dart';
import 'package:vms/views/maker/new_appointment.dart';
import 'package:vms/views/wrapper.dart';

class AuthNewAppointment extends StatelessWidget {
  const AuthNewAppointment({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrapper(widget: NewAppointment());
  }
}
