import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:vms/custom_classes/palette.dart';
import 'package:vms/data/appointment_statuses.dart';
import 'package:vms/helperfunctions/modify_appointment.dart';
import 'package:vms/helperfunctions/custom_date_formatter.dart';
import 'package:vms/models/appointment.dart';
import 'package:vms/models/floor.dart';
import 'package:vms/models/group_head.dart';
import 'package:vms/models/host.dart';
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
  final String appointmentId;
  final DateTime endTime;
  final String officialityText;
  final String appointmentTypeText;
  final DateTime date;
  final String address;
  final int noOfGuests;
  final Host host;
  final String staffImagePath;
  final List<dynamic> guests;
  final dynamic groupHead;
  final Floor floor;
  final dynamic location;
  final String meetingRoom;

  AppointmentRequestsCard({
    Key? key,
    required this.startTime,
    required this.appointmentId,
    required this.endTime,
    required this.officialityText,
    required this.appointmentTypeText,
    required this.date,
    required this.address,
    required this.noOfGuests,
    required this.staffImagePath,
    required this.host,
    required this.floor,
    required this.meetingRoom,
    required this.location,
    required this.guests,
    required this.groupHead,
  }) : super(key: key);

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

  // approveOrDeny(int approveOrDeny) async {
  //   Appointment appointment = Appointment(
  //     id: widget.appointmentId,
  //     host: widget.host,
  //     visitType: widget.officialityText,
  //     startTime: widget.startTime,
  //     endTime: widget.endTime,
  //     groupHead: widget.groupHead,
  //     appointmentType: widget.appointmentTypeText,
  //     appointmentStatus: appointmentStatuses[approveOrDeny]["value"],
  //     appointmentDate: widget.date,
  //     floorNumber: widget.floorNumber,
  //     guests: widget.guests,
  //     meetingRoom: widget.meetingRoom,
  //     rooms: [],
  //     location: widget.location,
  //   );
  //   String denied = "denied";
  //   String approved = "approved";
  //   String approveOrDenyText = "";

  //   if (approveOrDeny == 1) {
  //     approveOrDenyText = approved;
  //   } else {
  //     approveOrDenyText = denied;
  //   }

  //   service.updateAppointment(appointment, widget.appointmentId).then((result) {
  //     setState(() {
  //       updateLoading = false;
  //     });
  //     print("result : " + result.toString());
  //     print("result.data : " + result.data.toString());
  //     var title;
  //     var text;
  //     if (result.data != null) {
  //       title = "Success";
  //       text = "Appointment has been $approveOrDenyText";
  //     } else {
  //       title = "Error";
  //       text =
  //           "Appointment could not be $approveOrDenyText. Please try again later";
  //     }
  //     showDialog<String>(
  //       barrierDismissible: false,
  //       context: context,
  //       builder: (BuildContext context) => updateLoading
  //           ? AlertDialog(
  //               content: Container(
  //                 height: 50,
  //                 width: 50,
  //                 child: Center(
  //                   child: CircularProgressIndicator(
  //                     color: Palette.FBN_BLUE,
  //                   ),
  //                 ),
  //               ),
  //             )
  //           : AlertDialog(
  //               title: Text(title),
  //               content: Text(text),
  //               actions: <Widget>[
  //                 TextButton(
  //                   onPressed: () {
  //                     Navigator.pushNamed(context, '/appointment_requests');
  //                   },
  //                   child: const Text(
  //                     'OK',
  //                     style: TextStyle(
  //                       color: Palette.FBN_BLUE,
  //                     ),
  //                   ),
  //                 ),
  //               ],
  //             ),
  //     );
  //   });
  // }

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
                  host: widget.host, staffImagePath: widget.staffImagePath),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 6),
                child: Row(
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 5),
                      child: OfficialityStatus(
                        officialityText: widget.officialityText,
                        officialityBackgroundColor: Palette.FBN_BLUE,
                        textColor: Palette.CUSTOM_WHITE,
                      ),
                    ),
                    SizedBox(width: 6),
                    Container(
                      margin: EdgeInsets.only(top: 5),
                      child: AppointmentType(
                        appointmentTypeText: widget.appointmentTypeText,
                        backgroundColor: Palette.CUSTOM_YELLOW,
                        textColor: Palette.CUSTOM_WHITE,
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
                  noOfGuests: widget.noOfGuests,
                ),
              ),
            ],
          ),
          Container(
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
                      //2 means denied which matches with the index of 'deny' in the appointmentStatuses list
                      Appointment appointment = Appointment(
                        id: widget.appointmentId,
                        host: widget.host,
                        visitType: widget.officialityText,
                        startTime: widget.startTime,
                        endTime: widget.endTime,
                        groupHead: widget.groupHead,
                        appointmentType: widget.appointmentTypeText,
                        appointmentStatus: DENY,
                        appointmentDate: widget.date,
                        floor: widget.floor,
                        guests: widget.guests,
                        meetingRoom: widget.meetingRoom,
                        rooms: [],
                        location: widget.location,
                      );
                      modifyAppointment(
                        DENY,
                        appointment,
                        context,
                        service,
                        setState,
                        updateLoading,
                        "/appointment_requests",
                      );
                    },
                    fnTwo: () async {
                      setState(() {
                        updateLoading = true;
                      });
                      Appointment appointment = Appointment(
                        id: widget.appointmentId,
                        host: widget.host,
                        visitType: widget.officialityText,
                        startTime: widget.startTime,
                        endTime: widget.endTime,
                        groupHead: widget.groupHead,
                        appointmentType: widget.appointmentTypeText,
                        appointmentStatus: APPROVE,
                        appointmentDate: widget.date,
                        floor: widget.floor,
                        guests: widget.guests,
                        meetingRoom: widget.meetingRoom,
                        rooms: [],
                        location: widget.location,
                      );
                      modifyAppointment(
                        APPROVE,
                        appointment,
                        context,
                        service,
                        setState,
                        updateLoading,
                        "/appointment_requests",
                      );
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
