import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:vms/custom_classes/palette.dart';
import 'package:vms/custom_widgets/custom_text_with_background.dart';
import 'package:vms/data/appointment_statuses.dart';
import 'package:vms/helperfunctions/modify_appointment.dart';
import 'package:vms/helperfunctions/custom_date_formatter.dart';
import 'package:vms/models/appointment.dart';
import 'package:vms/models/approve_appointment.dart';
import 'package:vms/models/cancel_appointment.dart';
import 'package:vms/models/floor.dart';
import 'package:vms/models/group_head.dart';
import 'package:vms/models/host.dart';
import 'package:vms/notifiers/appointment_notifier.dart';
import 'package:vms/notifiers/user_notifier.dart';
import 'package:vms/partials/appointment_requests/address.dart';
import 'package:vms/partials/appointment_requests/appointment_type.dart';
import 'package:vms/partials/appointment_requests/guests.dart';
import 'package:vms/partials/appointment_requests/officiality_status.dart';
import 'package:vms/partials/appointment_requests/staff_details.dart';
import 'package:vms/partials/appointment_requests/time_stamp.dart';
import 'package:vms/partials/common/bottom_fixed_section_small.dart';
import 'package:vms/services/appointment_service.dart';

class AppointmentRequestsCard extends StatefulWidget {
  final DateTime startTime;
  final int appointmentId;
  final DateTime endTime;
  final String visitorType;
  final String visitPurpose;
  final String visitStatus;
  final DateTime date;
  final String address;
  final int noOfGuests;
  final Host host;
  final String staffImagePath;
  final List<dynamic> guests;
  final dynamic groupHead;
  final String floor;
  final dynamic location;
  final String meetingRooms;
  final String cancelReason;
  final String rescheduleReason;
  final bool showApproveDeny;

  AppointmentRequestsCard(
      {Key? key,
      required this.showApproveDeny,
      required this.startTime,
      required this.appointmentId,
      required this.endTime,
      required this.visitorType,
      required this.visitStatus,
      required this.visitPurpose,
      required this.date,
      required this.address,
      required this.noOfGuests,
      required this.staffImagePath,
      required this.host,
      required this.floor,
      required this.meetingRooms,
      required this.location,
      required this.guests,
      required this.groupHead,
      this.cancelReason = "",
      this.rescheduleReason = ""})
      : super(key: key);

  @override
  State<AppointmentRequestsCard> createState() =>
      _AppointmentRequestsCardState();
}

class _AppointmentRequestsCardState extends State<AppointmentRequestsCard> {
  AppointmentService get service => GetIt.I<AppointmentService>();

  UserNotifier _userNotifier = UserNotifier();

  bool isGH = false;
  bool updateLoading = false;
  bool isLoading = false;

  String getTimes(startTime, endTime) {
    return "$startTime - $endTime";
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      decoration: BoxDecoration(
        color: Palette.CUSTOM_WHITE,
        borderRadius: BorderRadius.all(Radius.circular(15)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 10,
            offset: Offset(0, 1), // changes position of shadow
          ),
        ],
      ),
      child: Column(
        children: [
          Column(
            children: [
              StaffDetails(
                host: widget.host,
                staffImagePath: widget.staffImagePath,
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 6),
                child: Row(
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 5),
                      child: CustomTextWithBackground(
                        text: widget.visitorType,
                        textColor: Palette.CUSTOM_WHITE,
                        backgroundColor: Palette.FBN_BLUE,
                        fn: () {},
                      ),
                    ),
                    SizedBox(width: 6),
                    Container(
                      margin: EdgeInsets.only(top: 5),
                      child: CustomTextWithBackground(
                        text: widget.visitPurpose,
                        textColor: Palette.CUSTOM_WHITE,
                        backgroundColor: Palette.CUSTOM_YELLOW,
                        fn: () {},
                      ),
                    ),
                    SizedBox(width: 6),
                    Container(
                      margin: EdgeInsets.only(top: 5),
                      child: CustomTextWithBackground(
                        text: widget.visitStatus,
                        textColor: Palette.CUSTOM_WHITE,
                        backgroundColor:
                            widget.visitStatus.toLowerCase() == "approved"
                                ? Palette.FBN_GREEN
                                : (widget.visitStatus.toLowerCase() == "pending"
                                    ? Palette.FBN_ORANGE
                                    : Colors.red),
                        fn: () {},
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 5),
                child: TimeStamp(
                  date: CustomDateFormatter.getFormatedDate(widget.date),
                  time: getTimes(
                      CustomDateFormatter.getFormattedTime(widget.startTime),
                      CustomDateFormatter.getFormattedTime(widget.endTime)),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 5),
                child: Address(
                  address: widget.address,
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 5),
                child: Guests(
                  guests: widget.guests,
                ),
              ),
            ],
          ),
          widget.showApproveDeny
              ? Container(
                  margin: EdgeInsets.only(top: 15),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Container(),
                      ),
                      Expanded(
                        flex: 3,
                        child: BottomFixedSectionSmall(
                          leftText: "Deny",
                          rightText: "Approve",
                          fnOne: () async {
                            setState(() {
                              updateLoading = true;
                            });

                            CancelAppointment cancelDetails = CancelAppointment(
                              visitId: widget.appointmentId,
                              reason: "Declined by group head",
                            );
                            cancelAppointment(
                                cancelDetails,
                                service,
                                context,
                                '/appointment_requests',
                                setState,
                                updateLoading);
                          },
                          fnTwo: () async {
                            setState(() {
                              updateLoading = true;
                            });

                            ApproveAppointment approveDetails =
                                ApproveAppointment(
                                    visitId: widget.appointmentId);
                            approveAppointment(
                                approveDetails,
                                service,
                                context,
                                '/appointment_requests',
                                setState,
                                updateLoading);
                          },
                        ),
                      ),
                    ],
                  ),
                )
              : Container(),
        ],
      ),
    );
  }
}
