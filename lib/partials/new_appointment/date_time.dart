import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:async';
import 'package:vms/custom_classes/palette.dart';
import 'package:vms/custom_widgets/custom_date_time_selector.dart';
import 'package:vms/custom_widgets/custom_drop_down.dart';
import 'package:vms/custom_widgets/custom_error_label.dart';
import 'package:vms/custom_widgets/custom_input_label.dart';
import 'package:vms/helperfunctions/custom_date_formatter.dart';
import 'package:vms/notifiers/appointment_notifier.dart';
import 'package:vms/notifiers/time_selection_notifier.dart';

class DateTimeSection extends StatelessWidget {
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime.now().subtract(Duration(days: 0)),
      lastDate: DateTime(2101),
      builder: (context, child) {
        return Theme(
          data: ThemeData.dark().copyWith(
            colorScheme: ColorScheme.dark(
              primary: Palette.CUSTOM_YELLOW,
              onPrimary: Colors.white,
              surface: Palette.CUSTOM_YELLOW,
              onSurface: Palette.CUSTOM_WHITE,
            ),
            dialogBackgroundColor: Palette.FBN_BLUE,
          ),
          child: Container(
            child: child,
          ),
        );
      },
    );

    if (picked != null && picked != selectedDate) {
      context.read<AppointmentNotifier>().addAppointmentDate(picked);
      print(context.read<AppointmentNotifier>().appointments.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    AppointmentNotifier appointmentNotifier =
        Provider.of<AppointmentNotifier>(context, listen: false);
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomInputLabel(labelText: "Date"),
          CustomErrorLabel(
              errorText: appointmentNotifier
                  .allNewAppointmentErrors["appointmentDate"]),
          CustomDateTimeSelector(
            icon: Icon(
              Icons.calendar_today,
              color: Palette.FBN_BLUE,
            ),
            onTap: () {
              _selectDate(context);
              appointmentNotifier.removeError("appointmentDate");
              appointmentNotifier.removeError("startTime");
              appointmentNotifier.removeError("endTime");
            },
            selectedText: CustomDateFormatter.getFormatedDate(context
                .watch<AppointmentNotifier>()
                .appointments[appointmentNotifier.appointments.length - 1]
                .appointmentDate),
          ),
          Row(
            children: [
              Expanded(
                flex: 5,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomInputLabel(labelText: "Start Time"),
                    CustomErrorLabel(
                        errorText: appointmentNotifier
                            .allNewAppointmentErrors["startTime"]),
                    CustomDropDown(
                      onTap: (value) {
                        print(value);
                        context.read<AppointmentNotifier>().addStartTime(value);
                        appointmentNotifier.removeError("startTime");
                      },
                      text: CustomDateFormatter.getTimeStringFromDateTime(
                          context
                              .watch<AppointmentNotifier>()
                              .appointments[0]
                              .startTime),
                      lists:
                          context.watch<TimeSelectionNotifier>().times.toSet(),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(),
              ),
              Expanded(
                flex: 5,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomInputLabel(labelText: "End Time"),
                    CustomErrorLabel(
                        errorText: appointmentNotifier
                            .allNewAppointmentErrors["endTime"]),
                    CustomDropDown(
                        onTap: (value) {
                          print(value);
                          context.read<AppointmentNotifier>().addEndTime(value);
                          appointmentNotifier.removeError("endTime");
                        },
                        text: CustomDateFormatter.getTimeStringFromDateTime(
                            context
                                .watch<AppointmentNotifier>()
                                .appointments[0]
                                .endTime),
                        lists: context
                            .read<TimeSelectionNotifier>()
                            .times
                            .toSet()),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
