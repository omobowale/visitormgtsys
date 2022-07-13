import 'package:flutter/material.dart';
import 'package:vms/views/maker/appointment_creation_success.dart';
import 'package:vms/views/wrapper.dart';

class AuthAppointmentCreationSuccess extends StatelessWidget {
  const AuthAppointmentCreationSuccess({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrapper(widget: AppointmentCreationSuccess());
  }
}
