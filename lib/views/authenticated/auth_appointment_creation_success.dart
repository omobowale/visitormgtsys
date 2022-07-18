import 'package:flutter/material.dart';
import 'package:vms/views/maker/appointment_creation_success.dart';
import 'package:vms/views/wrapper.dart';

class AuthAppointmentCreationSuccess extends StatelessWidget {
  bool loading;
  AuthAppointmentCreationSuccess({Key? key, this.loading = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrapper(
      widget: loading
          ? Center(
              child: CircularProgressIndicator(
              color: Colors.blue,
            ))
          : AppointmentCreationSuccess(),
    );
  }
}
