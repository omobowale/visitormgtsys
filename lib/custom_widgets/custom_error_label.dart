import 'package:flutter/material.dart';

class CustomErrorLabel extends StatelessWidget {
  final String? errorText;
  const CustomErrorLabel({Key? key, required this.errorText}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: (errorText != null && errorText != ""),
      child: Text(
        errorText ?? "",
        style: TextStyle(
          color: Colors.red,
        ),
      ),
      replacement: SizedBox.shrink(),
    );
  }
}
