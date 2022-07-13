import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:vms/constants/index.dart';
import 'package:vms/custom_widgets/custom_alert_dialog_box.dart';
import 'package:vms/custom_widgets/custom_info_display.dart';
import 'package:vms/models/api_response.dart';
import 'package:vms/models/appointment.dart';
import 'package:vms/notifiers/appointment_notifier.dart';
import 'package:vms/partials/common/bottom_fixed_section.dart';
import 'package:vms/partials/common/confirmation_modal.dart';
import 'package:vms/partials/common/top.dart';
import 'package:vms/partials/summary/add_another_link.dart';
import 'package:vms/services/appointment_service.dart';
import 'package:vms/views/authenticated/auth_view.dart';
import 'package:vms/views/commons/details_summary_appointment.dart';
import 'package:vms/views/commons/details_summary_guests.dart';
import 'package:vms/views/commons/details_summary_location.dart';
import 'package:vms/views/maker/visitor_information.dart';
import 'package:vms/views/maker/appointment_creation_success.dart';
import 'package:vms/views/view.dart';

class Summary extends StatefulWidget {
  const Summary({Key? key}) : super(key: key);

  @override
  State<Summary> createState() => _SummaryState();
}

class _SummaryState extends State<Summary> {
  AppointmentService get service => GetIt.I<AppointmentService>();
  late APIResponse<Appointment> appointment;
  bool isLoading = false;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  Future<void> navigateToSuccessPage(
      BuildContext context, VoidCallback onSuccess) async {
    await Future.delayed(const Duration(seconds: 2));
    onSuccess.call();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    appointment = APIResponse<Appointment>(data: null, error: false);
    isLoading = false;
  }

  @override
  Widget build(BuildContext context) {
    AppointmentNotifier _appointmentNotifier =
        Provider.of<AppointmentNotifier>(context);
    return Scaffold(
      key: _scaffoldKey,
      body: ListView(
        children: [
          TopSection(
            leftText: "Summary",
            rightText: "Cancel",
          ),
          Divider(),
          DetailsSummaryAppointment(
            isSummary: true,
          ),
          Divider(),
          DetailsSummaryLocation(),
          Divider(),
          DetailsSummaryGuests(),
          Divider(),
          context.read<AppointmentNotifier>().getValidGuests().length >=
                  MAXIMUM_NUMBER_OF_GUESTS
              ? Container()
              : AddAnotherLink(),
          BottomFixedSection(
            leftText: "Back",
            rightText: "Submit",
            fnOne: () {
              Navigator.pushNamed(context, '/visitor_information');
            },
            fnTwo: () {
              showModalBottomSheet<void>(
                backgroundColor: Colors.transparent,
                context: context,
                builder: (BuildContext context) {
                  return ConfirmationModal(
                    confirmationTextTitle: "Are you sure?",
                    confirmationTextDescription:
                        "You are about to submit this appointment, you will not be able to modify it again",
                    acceptFunction: () async {
                      Navigator.of(context).pop();

                      var newAppointment = _appointmentNotifier.appointments[0];

                      var response = await service.createAppointment(
                          newAppointment, context);
                      print("error: ${response.error}");
                      print("error message: ${response.errorMessage}");

                      if (response.error == true ||
                          response.errorMessage != "") {
                        showDialog(
                            context: _scaffoldKey.currentContext!,
                            builder: (ctx) {
                              return CustomAlertDialogBox(
                                  textTitle: "Error",
                                  textContent: response.errorMessage ??
                                      "Could not create appointment",
                                  color: Colors.red,
                                  function: () {
                                    Navigator.pop(ctx);
                                  },
                                  redirectLocation: '');
                            });
                        print("There was an error");
                      } else {
                        await navigateToSuccessPage(
                            _scaffoldKey.currentContext!, () {
                          print("I am here now again");
                          Navigator.pushNamedAndRemoveUntil(
                              _scaffoldKey.currentContext!,
                              '/appointment_creation_success',
                              (route) => false);
                        });
                      }
                      // }
                    },
                    declineFunction: () {
                      Navigator.of(context).pop();
                    },
                  );
                },
              ).then((value) => null);
            },
          ),
        ],
      ),
    );
  }
}
