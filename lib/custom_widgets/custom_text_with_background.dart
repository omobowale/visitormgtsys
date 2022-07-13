import 'package:flutter/material.dart';

class CustomTextWithBackground extends StatelessWidget {
  final String text;
  final Color textColor;
  final Color backgroundColor;
  final Function fn;

  const CustomTextWithBackground({
    Key? key,
    required this.text,
    required this.textColor,
    required this.backgroundColor,
    required this.fn,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        fn();
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: backgroundColor,
        ),
        child: Text(
          text,
          style: TextStyle(
            fontWeight: FontWeight.w500,
            color: textColor,
          ),
        ),
      ),
    );
  }
}
