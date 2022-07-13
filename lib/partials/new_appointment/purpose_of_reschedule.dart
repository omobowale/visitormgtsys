import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vms/custom_classes/palette.dart';
import 'package:vms/custom_widgets/custom_drop_down.dart';
import 'package:vms/custom_widgets/custom_error_label.dart';
import 'package:vms/custom_widgets/custom_input_field.dart';
import 'package:vms/custom_widgets/custom_input_label.dart';
import 'package:vms/helperfunctions/enumerationExtraction.dart';
import 'package:vms/helperfunctions/modify_appointment.dart';
import 'package:vms/notifiers/appointment_notifier.dart';
import 'package:vms/notifiers/login_logout_notifier.dart';

class ReschedulePurpose extends StatefulWidget {
  const ReschedulePurpose({Key? key}) : super(key: key);

  @override
  State<ReschedulePurpose> createState() => _ReschedulePurposeState();
}

class _ReschedulePurposeState extends State<ReschedulePurpose> {
  late List<Map<String, dynamic>> list = [
    {"0": "others"}
  ];
  bool othersInputVisible = false;

  @override
  void initState() {
    // TODO: implement initState
    var newlist = getAndSetEnumeration(
        context.read<LoginLogoutNotifier>().allEnums, "cancellationReasonEnum");
    list = newlist.isEmpty ? list : newlist;

    super.initState();
  }

  bool isInList(List<dynamic> list, String purposeOfReschedule) {
    try {
      var x = list.firstWhere((element) => element == purposeOfReschedule);
      if (x.isNotEmpty) {
        return true;
      }
      return false;
    } on StateError {
      return false;
    }
  }

  String setStateAndReturn(String x) {
    setState(() {
      othersInputVisible = true;
    });
    return x;
  }

  @override
  Widget build(BuildContext context) {
    AppointmentNotifier _appointmentNotifier =
        Provider.of<AppointmentNotifier>(context);
    String purposeOfReschedule =
        _appointmentNotifier.appointments[0].purposeOfReschedule ?? "";
    return Container(
      margin: EdgeInsets.only(left: 20, right: 20, bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomErrorLabel(
            errorText: othersInputVisible
                ? ""
                : _appointmentNotifier
                    .allNewAppointmentErrors["purposeOfReschedule"],
          ),
          CustomDropDown(
            onTap: (value) {
              if (value.toString().toLowerCase() == "others") {
                _appointmentNotifier.addPurposeOfReschedule("");
                setState(() {
                  othersInputVisible = true;
                });
                print("others selected");
              } else {
                _appointmentNotifier.removeError("purposeOfReschedule");
                _appointmentNotifier.addPurposeOfReschedule(value);
                setState(() {
                  othersInputVisible = false;
                });
              }
            },
            text: purposeOfReschedule == ""
                ? list[0]["name"]
                : isInList(extractReasons(list), purposeOfReschedule)
                    ? purposeOfReschedule
                    : setStateAndReturn(list[list.length - 1]["name"]),
            lists: extractReasons(list).toSet(),
          ),
          Visibility(
            visible: othersInputVisible,
            child: Container(
              margin: EdgeInsets.only(top: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomInputLabel(labelText: "Others? Please specify"),
                  CustomErrorLabel(
                    errorText: !othersInputVisible
                        ? ""
                        : _appointmentNotifier
                            .allNewAppointmentErrors["purposeOfReschedule"],
                  ),
                  CustomInputField(
                    bordered: false,
                    hintText: "Others",
                    labelText: _appointmentNotifier
                            .appointments[0].purposeOfReschedule ??
                        "",
                    onComplete: (value) {
                      _appointmentNotifier.removeError("purposeOfReschedule");
                      _appointmentNotifier.addPurposeOfReschedule(value);
                    },
                  ),
                ],
              ),
            ),
            replacement: Container(),
          ),
        ],
      ),
    );
  }
}
