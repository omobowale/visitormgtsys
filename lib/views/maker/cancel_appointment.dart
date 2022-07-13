import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:vms/helperfunctions/modify_appointment.dart';
import 'package:vms/notifiers/appointment_notifier.dart';
import 'package:vms/partials/common/bottom_fixed_section.dart';
import 'package:vms/partials/common/confirmation_modal.dart';
import 'package:vms/partials/common/top_swap.dart';
import 'package:vms/partials/new_appointment/date_time.dart';
import 'package:vms/partials/new_appointment/purpose_of_cancel.dart';
import 'package:vms/partials/new_appointment/purpose_of_reschedule.dart';
import 'package:vms/services/appointment_service.dart';
import 'package:vms/views/maker/details.dart';
import 'package:vms/views/view.dart';

class CancelAppointment extends StatefulWidget {
  const CancelAppointment({Key? key}) : super(key: key);

  @override
  State<CancelAppointment> createState() => _CancelAppointmentState();
}

class _CancelAppointmentState extends State<CancelAppointment> {
  AppointmentService get service => GetIt.I<AppointmentService>();
  bool updateLoading = false;
  @override
  Widget build(BuildContext context) {
    context
        .read<AppointmentNotifier>()
        .showAppointment(context.read<AppointmentNotifier>().appointments[0]);
    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(top: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                TopSwapSection(
                  leftText: "Cancel",
                  rightText: "Cancel Appointment",
                  fnOne: () {
                    Navigator.of(context).pop();
                  },
                ),
                Container(
                  margin: EdgeInsets.only(top: 20),
                  child: CancelPurpose(),
                ),
              ],
            ),
            BottomFixedSection(
              leftText: "Back",
              rightText: "Continue",
              fnOne: () {
                Navigator.of(context).pop();
              },
              fnTwo: () {
                context.read<AppointmentNotifier>().isCancelValid();
                if (context
                    .read<AppointmentNotifier>()
                    .allNewAppointmentErrors
                    .isEmpty) {
                  setState(() {
                    updateLoading = true;
                  });
                  var appointment =
                      context.read<AppointmentNotifier>().appointments[0];
                  appointment.appointmentStatus = CANCEL;

                  modifyAppointment(CANCEL, appointment, context, service,
                      setState, updateLoading, "/appointment_updated");
                } else {
                  print("There is an error");
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
