import 'package:flutter/material.dart';

class CustomRichText extends StatelessWidget {
  final String prop;
  final String value;
  const CustomRichText({Key? key, required this.prop, required this.value})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: "${prop}: ",
        style: TextStyle(
          color: Colors.grey,
        ),
        children: [
          TextSpan(
            text: "${value}",
            style: TextStyle(
              fontWeight: FontWeight.w400,
              color: Colors.black.withOpacity(0.9),
              fontSize: 15,
            ),
          ),
        ],
      ),
    );
  }
}
