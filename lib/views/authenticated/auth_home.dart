import 'package:flutter/material.dart';
import 'package:vms/views/home.dart';
import 'package:vms/views/wrapper.dart';

class AuthHome extends StatelessWidget {
  const AuthHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrapper(
      widget: Home(),
    );
  }
}
