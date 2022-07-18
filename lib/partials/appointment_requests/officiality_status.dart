import 'package:flutter/material.dart';
import 'package:vms/custom_widgets/custom_text_with_background.dart';

class OfficialityStatus extends StatelessWidget {
  final String visitorType;
  final Color textColor;
  final Color officialityBackgroundColor;

  const OfficialityStatus({
    Key? key,
    required this.visitorType,
    required this.officialityBackgroundColor,
    required this.textColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomTextWithBackground(
      text: visitorType,
      textColor: textColor,
      backgroundColor: officialityBackgroundColor,
      fn: () {},
    );
  }
}
