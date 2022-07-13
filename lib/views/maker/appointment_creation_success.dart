import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vms/custom_widgets/custom_info_display.dart';
import 'package:vms/custom_widgets/custom_single_line_button.dart';
import 'package:vms/notifiers/appointment_notifier.dart';
import 'package:vms/views/view.dart';

class AppointmentCreationSuccess extends StatelessWidget {
  const AppointmentCreationSuccess({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: InformationDisplay(
      infoImagePath: "assets/images/appointment_creation_success.png",
      messageTitle: "Request Created",
      messageBody:
          "Your appointment request has been submitted, you will receive a notification once your Supervisor receives it",
      buttonText: "Done",
      buttonFunction: () {
        context.read<AppointmentNotifier>().setIsCreating = false;
        Navigator.pushNamedAndRemoveUntil(context, '/view', (route) => false);
      },
    ));
  }
}
