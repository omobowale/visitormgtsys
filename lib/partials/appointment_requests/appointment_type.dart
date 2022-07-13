import 'package:flutter/material.dart';
import 'package:vms/custom_widgets/custom_text_with_background.dart';

class AppointmentType extends StatelessWidget {
  final String appointmentTypeText;
  final Color textColor;
  final Color backgroundColor;

  const AppointmentType(
      {Key? key,
      required this.appointmentTypeText,
      required this.textColor,
      required this.backgroundColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomTextWithBackground(
        text: appointmentTypeText,
        textColor: textColor,
        backgroundColor: backgroundColor,
        fn: () {});
  }
}
