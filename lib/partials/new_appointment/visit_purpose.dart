import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vms/custom_widgets/custom_error_label.dart';
import 'package:vms/custom_widgets/custom_input_label.dart';
import 'package:vms/custom_widgets/custom_radio_button.dart';
import 'package:vms/notifiers/appointment_notifier.dart';

class VisitPurpose extends StatelessWidget {
  List<Map<String, dynamic>> visitPurposesList;
  VisitPurpose({required this.visitPurposesList});

  @override
  Widget build(BuildContext context) {
    AppointmentNotifier _appointmentNotifier =
        Provider.of<AppointmentNotifier>(context, listen: true);

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            child: CustomInputLabel(
              labelText: "Visit Purpose",
            ),
          ),
          CustomErrorLabel(
              errorText:
                  _appointmentNotifier.allNewAppointmentErrors["visitPurpose"]),
          ...visitPurposesList.map((e) {
            return CustomRadioButton(
                isClicked: (value) {
                  _appointmentNotifier.addVisitPurpose(value);
                  _appointmentNotifier.removeError("visitPurpose");
                },
                checkText: _appointmentNotifier.appointments[0].visitPurpose,
                labelText: e["name"],
                isAvailable: true);
          }).toList(),
        ],
      ),
    );
  }
}
