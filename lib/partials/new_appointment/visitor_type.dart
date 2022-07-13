import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vms/custom_widgets/custom_error_label.dart';
import 'package:vms/custom_widgets/custom_input_label.dart';
import 'package:vms/custom_widgets/custom_radio_button.dart';
import 'package:vms/notifiers/appointment_notifier.dart';

class VisitorType extends StatelessWidget {
  List<Map<String, dynamic>> visitorTypesList;
  VisitorType({required this.visitorTypesList});
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
            child: CustomInputLabel(labelText: "Visitor Type"),
          ),
          CustomErrorLabel(
            errorText:
                _appointmentNotifier.allNewAppointmentErrors["appointmentType"],
          ),
          ...visitorTypesList
              .map(
                (e) => CustomRadioButton(
                  isClicked: (value) {
                    _appointmentNotifier.addVisitorType(value);
                    _appointmentNotifier.removeError("appointmentType");
                  },
                  checkText:
                      _appointmentNotifier.appointments[0].appointmentType,
                  labelText: e["name"],
                  isAvailable: true,
                ),
              )
              .toList(),
        ],
      ),
    );
  }
}
