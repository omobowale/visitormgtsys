import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/material.dart';

class LoginWelcomeSection extends StatelessWidget {
  const LoginWelcomeSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.fromLTRB(6, 10, 10, 0),
          padding: EdgeInsets.all(0),
          child: Text(
            "Welcome back",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Color(0xff000000),
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.fromLTRB(6, 0, 10, 10),
          child: Text(
            "Login to your account",
            style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: Color.fromRGBO(0, 0, 0, 0.56)),
          ),
        ),
      ],
    );
  }
}
