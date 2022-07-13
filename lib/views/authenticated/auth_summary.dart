import 'package:flutter/material.dart';
import 'package:vms/views/maker/summary.dart';
import 'package:vms/views/wrapper.dart';

class AuthSummary extends StatelessWidget {
  const AuthSummary({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrapper(widget: Summary());
  }
}
