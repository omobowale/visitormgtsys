import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:vms/helperfunctions/modify_appointment.dart';
import 'package:vms/notifiers/appointment_notifier.dart';
import 'package:vms/partials/common/bottom_fixed_section.dart';
import 'package:vms/partials/common/top_swap.dart';
import 'package:vms/partials/new_appointment/date_time.dart';
import 'package:vms/partials/new_appointment/purpose_of_reschedule.dart';
import 'package:vms/services/appointment_service.dart';
import 'package:vms/views/view.dart';
import 'package:vms/models/reschedule_appointment.dart' as RescheduleApt;

class RescheduleAppointment extends StatefulWidget {
  const RescheduleAppointment({Key? key}) : super(key: key);

  @override
  State<RescheduleAppointment> createState() => _RescheduleAppointmentState();
}

class _RescheduleAppointmentState extends State<RescheduleAppointment> {
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
                  rightText: "Reschedule Appointment",
                  fnOne: () {
                    Navigator.of(context).pop();
                  },
                ),
                Container(
                  margin: EdgeInsets.only(top: 20),
                  child: ReschedulePurpose(),
                ),
                Divider(),
                DateTimeSection(),
                Divider(),
              ],
            ),
            BottomFixedSection(
              leftText: "Back",
              rightText: "Continue",
              fnOne: () {
                Navigator.of(context).pop();
              },
              fnTwo: () {
                context.read<AppointmentNotifier>().isRescheduleValid();
                if (context
                    .read<AppointmentNotifier>()
                    .allNewAppointmentErrors
                    .isEmpty) {
                  setState(() {
                    updateLoading = true;
                  });
                  var appointment =
                      context.read<AppointmentNotifier>().appointments[0];
                  appointment.appointmentStatus = RESCHEDULE;
                  print("Appointment before rescheduling: ");
                  context
                      .read<AppointmentNotifier>()
                      .showAppointment(appointment);

                  RescheduleApt.RescheduleAppointment rescheduleDetails =
                      RescheduleApt.RescheduleAppointment(
                    date: appointment.appointmentDate,
                    endTime: appointment.endTime,
                    startTime: appointment.startTime,
                    rescheduleReason: appointment.purposeOfCancel ?? "",
                    visitId: int.tryParse(appointment.id) ?? 0,
                  );
                  rescheduleAppointment(rescheduleDetails, service, context,
                      '/appointment_updated_success', setState, updateLoading);

                  // modifyAppointment(RESCHEDULE, appointment, context, service,
                  //     setState, updateLoading, "/appointment_updated");
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
