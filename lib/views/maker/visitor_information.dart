import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vms/notifiers/appointment_notifier.dart';
import 'package:vms/partials/common/bottom_fixed_section.dart';
import 'package:vms/partials/common/top.dart';
import 'package:vms/partials/visitor_information/visitor_address.dart';
import 'package:vms/partials/visitor_information/visitor_details.dart';

class VisitorInformation extends StatefulWidget {
  const VisitorInformation({Key? key}) : super(key: key);

  @override
  State<VisitorInformation> createState() => _VisitorInformationState();
}

class _VisitorInformationState extends State<VisitorInformation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          TopSection(
            leftText: "Visitor Information",
            rightText: "Cancel",
          ),
          const Divider(),
          VisitorDetails(),
          const VisitorAddress(),
          const Divider(),
          BottomFixedSection(
              leftText: "Back",
              rightText: "Continue",
              fnOne: () {
                Navigator.pushNamed(context, '/appointment_location');
              },
              fnTwo: () {
                context.read<AppointmentNotifier>().showAppointment(
                    context.read<AppointmentNotifier>().appointments[0]);

                context.read<AppointmentNotifier>().visitorInformationValid();
                if (context
                    .read<AppointmentNotifier>()
                    .allVisitorInformationErrors
                    .isEmpty) {
                  Navigator.pushNamed(context, '/summary');
                }
              }),
        ],
      ),
    );
  }
}
