import 'package:flutter/material.dart';
import 'package:vms/custom_widgets/custom_info_display.dart';
import 'package:vms/custom_widgets/custom_single_line_button.dart';
import 'package:vms/views/view.dart';

class AppointmentUpdatedSuccess extends StatelessWidget {
  const AppointmentUpdatedSuccess({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: InformationDisplay(
        infoImagePath: "assets/images/appointment_creation_success.png",
        messageTitle: "Request Updated",
        messageBody:
            "Your appointment request has been updated, you will receive a notification once your Supervisor receives it",
        buttonText: "Done",
        buttonFunction: () {
          Navigator.pushNamedAndRemoveUntil(context, '/view', (route) => false);
        },
      ),
    );
  }
}
