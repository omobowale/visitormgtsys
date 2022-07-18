import 'package:flutter/material.dart';
import 'package:vms/custom_widgets/custom_text_with_background.dart';

class AppointmentType extends StatelessWidget {
  final String visitPurpose;
  final Color textColor;
  final Color backgroundColor;

  const AppointmentType(
      {Key? key,
      required this.visitPurpose,
      required this.textColor,
      required this.backgroundColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomTextWithBackground(
        text: visitPurpose,
        textColor: textColor,
        backgroundColor: backgroundColor,
        fn: () {});
  }
}
