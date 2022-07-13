import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vms/custom_classes/palette.dart';
import 'package:vms/notifiers/appointment_notifier.dart';
import 'package:vms/views/maker/new_appointment.dart';

class CustomFloatingActionButton extends StatelessWidget {
  const CustomFloatingActionButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      width: 70,
      child: Material(
        type: MaterialType.transparency,
        child: Ink(
          decoration: BoxDecoration(
            border: Border.all(color: Palette.CUSTOM_WHITE, width: 5.0),
            color: Palette.CUSTOM_YELLOW,
            shape: BoxShape.circle,
          ),
          child: InkWell(
            borderRadius: BorderRadius.circular(500.0),
            onTap: () {
              Navigator.pushNamed(context, '/new_appointment');
            },
            child: Icon(
              Icons.add,
              //size: 50,
            ),
          ),
        ),
      ),
    );
  }
}
