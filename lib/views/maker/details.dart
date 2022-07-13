import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:vms/custom_classes/palette.dart';
import 'package:vms/custom_widgets/custom_single_line_button.dart';
import 'package:vms/helperfunctions/appointmentStatusExtractor.dart';
import 'package:vms/helperfunctions/modify_appointment.dart';
import 'package:vms/helperfunctions/custom_date_formatter.dart';
import 'package:vms/helperfunctions/enumerationExtraction.dart';
import 'package:vms/models/api_response.dart';
import 'package:vms/models/appointment.dart';
import 'package:vms/notifiers/appointment_notifier.dart';
import 'package:vms/notifiers/login_logout_notifier.dart';
import 'package:vms/notifiers/user_notifier.dart';
import 'package:vms/partials/common/bottom_fixed_section_small.dart';
import 'package:vms/partials/common/top_swap.dart';
import 'package:vms/services/appointment_service.dart';
import 'package:vms/views/commons/details_summary_appointment.dart';
import 'package:vms/views/commons/details_summary_guests.dart';
import 'package:vms/views/commons/details_summary_location.dart';

class Details extends StatefulWidget {
  final String id;
  final bool isApproved;
  const Details({Key? key, required this.id, required this.isApproved})
      : super(key: key);

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  AppointmentService get service => GetIt.I<AppointmentService>();
  bool isLoading = false;
  bool updateLoading = false;
  bool isApprovalLoading = false;
  bool isGH = false;
  APIResponse<Appointment> appointment =
      new APIResponse<Appointment>(data: null, error: false);
  UserNotifier _userNotifier = UserNotifier();
  List<Map<String, dynamic>> appointmentStatuses = [];
  late AppointmentNotifier _appointmentNotifier;
  late LoginLogoutNotifier _loginLogoutNotifier;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _appointmentNotifier =
        Provider.of<AppointmentNotifier>(context, listen: false);

    _loginLogoutNotifier =
        Provider.of<LoginLogoutNotifier>(context, listen: false);

    setState(() {
      isLoading = true;
      isApprovalLoading = true;
    });

    isGH = _userNotifier.isGH();

    service.getAppointment(widget.id).then((data) {
      appointment = data;
      _appointmentNotifier.loadSelectedAppointment(appointment.data);
      setState(() {
        isLoading = false;
      });
    });

    appointmentStatuses = getAndSetEnumeration(
        _loginLogoutNotifier.allEnums, "appointmentStatusEnum");
  }

  @override
  Widget build(BuildContext context) {
    UserNotifier _userNotifier = Provider.of<UserNotifier>(context);

    return Scaffold(
      appBar: AppBar(
        actions: [],
        toolbarHeight: 0,
      ),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(
                color: Palette.FBN_BLUE,
              ),
            )
          : Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    TopSwapSection(
                      leftText: "Back",
                      rightText: "Details",
                      fnOne: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    Divider(),
                    DetailsSummaryAppointment(
                        isSummary: false,
                        visitType: appointment.data?.visitType,
                        appointmentType: appointment.data?.appointmentType,
                        appointmentStatus:
                            (appointment.data?.appointmentStatus),
                        appointmentDate: CustomDateFormatter.getFormattedDay(
                            appointment.data?.appointmentDate ?? null),
                        startTime: CustomDateFormatter.getFormattedTime(
                            appointment.data?.startTime ?? null),
                        endTime: CustomDateFormatter.getFormattedTime(
                            appointment.data?.endTime ?? null)),
                    Divider(),
                    DetailsSummaryLocation(
                      floor: appointment.data?.floor,
                      roomNumbers: appointment.data?.rooms,
                      location: appointment.data?.location,
                      meetingRoom: appointment.data?.meetingRoom,
                    ),
                    Divider(),
                    DetailsSummaryGuests(
                      guests: appointment.data?.guests,
                    ),
                    Divider(),
                    widget.isApproved
                        ? CustomSingleLineButton(
                            text: "Generate QR",
                            backgroundColor: Palette.FBN_GREEN.withOpacity(0.2),
                            textColor: Palette.FBN_GREEN,
                            fn: () {},
                          )
                        : SizedBox.shrink(),
                    isApprovalLoading
                        ? Container()
                        : isGH &&
                                !widget.isApproved &&
                                canBeApproved(
                                    appointment.data!.appointmentStatus,
                                    appointmentStatuses)
                            ? BottomFixedSectionSmall(
                                leftText: "Deny",
                                rightText: "Approve",
                                fnOne: () {
                                  setState(() {
                                    updateLoading = true;
                                  });

                                  modifyAppointment(
                                      DENY,
                                      appointment.data!,
                                      context,
                                      service,
                                      setState,
                                      updateLoading,
                                      '/view');
                                },
                                fnTwo: () {
                                  setState(() {
                                    updateLoading = true;
                                  });
                                  modifyAppointment(
                                      APPROVE,
                                      appointment.data!,
                                      context,
                                      service,
                                      setState,
                                      updateLoading,
                                      '/view');
                                },
                              )
                            : Text(""),
                    Text(widget.id),
                  ],
                ),
                !canModify(appointment.data!)
                    ? Container()
                    : Container(
                        child: Column(
                          children: [
                            Container(
                              margin: EdgeInsets.symmetric(vertical: 5),
                              child: CustomSingleLineButton(
                                text: 'Cancel Appointment',
                                backgroundColor: Color(0xffF7F2F3),
                                textColor: Color(0xffED682F),
                                fn: () {
                                  Navigator.pushNamed(
                                          context, '/cancel_appointment')
                                      .then((value) {
                                    setState(() {});
                                  });
                                },
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 5, bottom: 20),
                              child: CustomSingleLineButton(
                                text: 'Reschedule Appointment',
                                backgroundColor: Color(0xffEBF1F7),
                                textColor: Palette.FBN_BLUE,
                                fn: () {
                                  Navigator.pushNamed(
                                          context, '/reschedule_appointment')
                                      .then((value) {
                                    setState(() {});
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
              ],
            ),
    );
  }
}
