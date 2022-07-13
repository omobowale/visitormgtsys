import 'dart:math';

import 'package:flutter/material.dart';
import 'package:vms/custom_classes/palette.dart';

class CustomInputFieldDisabled extends StatefulWidget {
  final String text;

  CustomInputFieldDisabled({
    Key? key,
    required this.text,
  }) : super(key: key);

  @override
  State<CustomInputFieldDisabled> createState() =>
      _CustomInputFieldDisabledState();
}

class _CustomInputFieldDisabledState extends State<CustomInputFieldDisabled> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      enabled: false,
      keyboardType: TextInputType.multiline,
      decoration: InputDecoration(
        // labelText: widget.labelText,
        labelStyle: TextStyle(
          color: Colors.black.withOpacity(0.7),
          fontSize: 17,
        ),
        hintText: widget.text,
        labelText: widget.text,
        hintStyle: TextStyle(color: Palette.LAVENDAR_GREY),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(
            color: Palette.LAVENDAR_GREY,
            width: 2.0,
          ),
        ),
      ),
    );
  }
}
