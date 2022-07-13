import 'package:flutter/material.dart';
import 'package:vms/custom_widgets/custom_radio_button.dart';

class CustomRadioGroup extends StatelessWidget {
  final List<CustomRadioButton> radiolist;
  final String labelText;

  const CustomRadioGroup(
      {Key? key, required this.radiolist, required this.labelText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(bottom: 10),
            child: Text(
              labelText,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Column(
            children: radiolist.map((customRadioButton) {
              return customRadioButton;
            }).toList(),
          ),
        ],
      ),
    );
  }
}
