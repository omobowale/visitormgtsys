import 'package:flutter/material.dart';
import 'package:vms/views/maker/cancel_appointment.dart';
import 'package:vms/views/wrapper.dart';

class AuthCancelAppointment extends StatelessWidget {
  const AuthCancelAppointment({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrapper(widget: CancelAppointment());
  }
}
