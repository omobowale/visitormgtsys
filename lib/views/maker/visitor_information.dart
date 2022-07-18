import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vms/models/visitor.dart';
import 'package:vms/notifiers/appointment_notifier.dart';
import 'package:vms/partials/common/bottom_fixed_section.dart';
import 'package:vms/partials/common/top.dart';
import 'package:vms/partials/visitor_information/visitor_address.dart';
import 'package:vms/partials/visitor_information/visitor_details.dart';

class VisitorInformation extends StatefulWidget {
  bool addNew;
  VisitorInformation({Key? key, this.addNew = false}) : super(key: key);

  @override
  State<VisitorInformation> createState() => _VisitorInformationState();
}

class _VisitorInformationState extends State<VisitorInformation> {
  late AppointmentNotifier _appointmentNotifier;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

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
                context.read<AppointmentNotifier>().currentGuestValid();
                if (context
                    .read<AppointmentNotifier>()
                    .allCurrentGuestErrors
                    .isEmpty) {
                  print(
                      "New guest before adding: ${context.read<AppointmentNotifier>().getNewGuest}");
                  if (widget.addNew) {
                    context.read<AppointmentNotifier>().addGuest(
                        context.read<AppointmentNotifier>().getNewGuest);
                  }
                  Navigator.pushNamed(context, '/summary');
                }
              }),
        ],
      ),
    );
  }
}
