import 'package:flutter/material.dart';
import 'package:vms/views/home.dart';
import 'package:vms/views/maker/details.dart';
import 'package:vms/views/wrapper.dart';

class AuthDetails extends StatefulWidget {
  final String id;
  final bool isApproved;
  const AuthDetails({Key? key, required this.id, required this.isApproved})
      : super(key: key);

  static const routeName = '/details';

  @override
  State<AuthDetails> createState() => _AuthDetailsState();
}

class _AuthDetailsState extends State<AuthDetails> {
  @override
  Widget build(BuildContext context) {
    return Wrapper(
      widget: Details(id: widget.id, isApproved: widget.isApproved),
    );
  }
}
