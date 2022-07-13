import 'package:flutter/material.dart';
import 'package:vms/views/maker/visitor_information.dart';
import 'package:vms/views/wrapper.dart';

class AuthVisitorInformation extends StatelessWidget {
  const AuthVisitorInformation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrapper(widget: VisitorInformation());
  }
}
