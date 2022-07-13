import 'package:flutter/material.dart';

class CustomInputLabel extends StatelessWidget {
  String labelText;
  CustomInputLabel({Key? key, required this.labelText}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 2),
      child: Text(
        labelText,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
