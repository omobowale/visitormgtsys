import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vms/custom_widgets/custom_error_label.dart';
import 'package:vms/custom_widgets/custom_input_field.dart';
import 'package:vms/custom_widgets/custom_input_label.dart';
import 'package:vms/notifiers/appointment_notifier.dart';

class VisitorDetails extends StatefulWidget {
  @override
  State<VisitorDetails> createState() => _VisitorDetailsState();
}

class _VisitorDetailsState extends State<VisitorDetails> {
  @override
  Widget build(BuildContext context) {
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
                        errorText: context
                            .watch<AppointmentNotifier>()
                            .allCurrentGuestErrors["firstName"]),
                    CustomInputField(
                      onComplete: (value) {
                        context
                            .read<AppointmentNotifier>()
                            .addVisitorFirstName(value);
                        context
                            .read<AppointmentNotifier>()
                            .removeError("firstName");
                      },
                      bordered: false,
                      hintText: "Enter First Name",
                      labelText: context
                          .watch<AppointmentNotifier>()
                          .getNewGuest
                          .firstName,
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
                        errorText: context
                            .watch<AppointmentNotifier>()
                            .allCurrentGuestErrors["lastName"]),
                    CustomInputField(
                      onComplete: (value) {
                        context
                            .read<AppointmentNotifier>()
                            .addVisitorLastName(value);
                        context
                            .read<AppointmentNotifier>()
                            .removeError("lastName");
                      },
                      bordered: false,
                      hintText: "Enter Last name",
                      labelText: context
                          .watch<AppointmentNotifier>()
                          .getNewGuest
                          .lastName,
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
                  errorText: context
                      .watch<AppointmentNotifier>()
                      .allCurrentGuestErrors["phoneNumber"]),
              CustomInputField(
                onComplete: (value) {
                  context
                      .read<AppointmentNotifier>()
                      .addVisitorPhoneNumber(value);
                  context
                      .read<AppointmentNotifier>()
                      .removeError("phoneNumber");
                },
                bordered: false,
                hintText: "Enter Phone Number",
                labelText: context
                    .watch<AppointmentNotifier>()
                    .getNewGuest
                    .phoneNumber,
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
                  errorText: context
                      .watch<AppointmentNotifier>()
                      .allCurrentGuestErrors["email"]),
              CustomInputField(
                onComplete: (value) {
                  context.read<AppointmentNotifier>().addVisitorEmail(value);
                  context.read<AppointmentNotifier>().removeError("email");
                },
                bordered: false,
                hintText: "Enter Email",
                labelText:
                    context.watch<AppointmentNotifier>().getNewGuest.email,
              ),
            ],
          ),
        ),
      ]),
    );
  }
}
