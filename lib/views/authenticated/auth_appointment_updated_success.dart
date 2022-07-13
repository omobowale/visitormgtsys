import 'package:flutter/material.dart';
import 'package:vms/views/maker/appointment_updated_success.dart';
import 'package:vms/views/wrapper.dart';

class AuthAppointmentUpdatedSuccess extends StatelessWidget {
  const AuthAppointmentUpdatedSuccess({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrapper(widget: AppointmentUpdatedSuccess());
  }
}
