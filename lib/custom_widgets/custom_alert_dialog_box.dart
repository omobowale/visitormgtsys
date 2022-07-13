import 'package:flutter/material.dart';

class CustomAlertDialogBox extends StatelessWidget {
  final String textTitle;
  final String textContent;
  final Color color;
  Function function;
  final String redirectLocation;

  CustomAlertDialogBox({
    Key? key,
    required this.textTitle,
    required this.textContent,
    required this.color,
    required this.redirectLocation,
    required this.function,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        textTitle,
        style: TextStyle(
          color: color,
          fontWeight: FontWeight.w500,
        ),
      ),
      content: Text(
        textContent,
        style: TextStyle(
          color: color,
        ),
      ),
      actions: <Widget>[
        ElevatedButton(
          onPressed: () {
            if (redirectLocation.isEmpty) {
              function();
            } else {
              Navigator.pushNamed(context, redirectLocation);
            }
          },
          child: Text("Ok"),
        ),
      ],
    );
  }
}
