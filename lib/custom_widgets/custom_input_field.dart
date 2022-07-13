import 'dart:math';

import 'package:flutter/material.dart';
import 'package:vms/custom_classes/palette.dart';

class CustomInputField extends StatefulWidget {
  final String hintText;
  Function? validator;
  final String labelText;
  final bool bordered;
  final int minLines;
  final int maxLines;
  final Function onComplete;
  String initialValue;

  CustomInputField({
    Key? key,
    required this.hintText,
    required this.labelText,
    this.validator,
    required this.bordered,
    required this.onComplete,
    this.initialValue = "",
    this.minLines = 1,
    this.maxLines = 1,
  }) : super(key: key);

  @override
  State<CustomInputField> createState() => _CustomInputFieldState();
}

class _CustomInputFieldState extends State<CustomInputField> {
  TextEditingController textEditingController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    textEditingController.text = widget.labelText;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: (value) {
        widget.onComplete(value);
      },
      validator: (value) {
        return widget.validator!(value);
      },
      controller: textEditingController,
      minLines: widget.minLines,
      maxLines: widget.maxLines,
      keyboardType: TextInputType.multiline,
      decoration: InputDecoration(
        // labelText: widget.labelText,
        labelStyle: TextStyle(
          color: Colors.black.withOpacity(0.7),
          fontSize: 17,
          // fontWeight: FontWeight.w500,
        ),
        hintText: widget.hintText,
        hintStyle: TextStyle(color: Palette.LAVENDAR_GREY),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(
            color: widget.bordered ? Palette.FBN_BLUE : Palette.LAVENDAR_GREY,
            width: 2,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(
            color: widget.bordered ? Palette.FBN_BLUE : Palette.LAVENDAR_GREY,
            width: 2.0,
          ),
        ),
      ),
    );
  }
}
