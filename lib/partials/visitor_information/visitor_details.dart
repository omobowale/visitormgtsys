import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vms/custom_widgets/custom_error_label.dart';
import 'package:vms/custom_widgets/custom_input_field.dart';
import 'package:vms/custom_widgets/custom_input_label.dart';
import 'package:vms/notifiers/appointment_notifier.dart';

class VisitorDetails extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AppointmentNotifier _appointmentNotifier =
        Provider.of<AppointmentNotifier>(context);
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      child: Column(children: [
        Container(
          margin: EdgeInsets.only(top: 10, bottom: 10),
          child: Row(
            children: [
              Expanded(
                flex: 10,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomInputLabel(labelText: "First name"),
                    CustomErrorLabel(
                        errorText: _appointmentNotifier
                            .allVisitorInformationErrors["firstName"]),
                    CustomInputField(
                      onComplete: (value) {
                        _appointmentNotifier.addVisitorFirstName(value);
                        _appointmentNotifier.removeError("firstName");
                      },
                      bordered: false,
                      hintText: "Enter First Name",
                      labelText: _appointmentNotifier
                          .appointments[0].guests[0].firstName,
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(),
              ),
              Expanded(
                flex: 10,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomInputLabel(labelText: "Last name"),
                    CustomErrorLabel(
                        errorText: _appointmentNotifier
                            .allVisitorInformationErrors["lastName"]),
                    CustomInputField(
                      onComplete: (value) {
                        _appointmentNotifier.addVisitorLastName(value);
                        _appointmentNotifier.removeError("lastName");
                      },
                      bordered: false,
                      hintText: "Enter Last name",
                      labelText: _appointmentNotifier
                          .appointments[0].guests[0].lastName,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.only(bottom: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomInputLabel(labelText: "Phone number"),
              CustomErrorLabel(
                  errorText: _appointmentNotifier
                      .allVisitorInformationErrors["phoneNumber"]),
              CustomInputField(
                onComplete: (value) {
                  _appointmentNotifier.addVisitorPhoneNumber(value);
                  _appointmentNotifier.removeError("phoneNumber");
                },
                bordered: false,
                hintText: "Enter Phone Number",
                labelText:
                    _appointmentNotifier.appointments[0].guests[0].phoneNumber,
              ),
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.only(bottom: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomInputLabel(labelText: "Email"),
              CustomErrorLabel(
                  errorText: _appointmentNotifier
                      .allVisitorInformationErrors["email"]),
              CustomInputField(
                onComplete: (value) {
                  _appointmentNotifier.addVisitorEmail(value);
                  _appointmentNotifier.removeError("email");
                },
                bordered: false,
                hintText: "Enter Email",
                labelText: _appointmentNotifier.appointments[0].guests[0].email,
              ),
            ],
          ),
        ),
      ]),
    );
  }
}
