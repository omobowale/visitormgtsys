import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vms/custom_classes/palette.dart';
import 'package:vms/custom_widgets/custom_text_with_background.dart';
import 'package:vms/data/appointment_statuses.dart';

import 'package:vms/helperfunctions/appointmentStatusExtractor.dart';
import 'package:vms/helperfunctions/custom_date_formatter.dart';
import 'package:vms/helperfunctions/enumerationExtraction.dart';
import 'package:vms/notifiers/appointment_notifier.dart';
import 'package:vms/notifiers/login_logout_notifier.dart';
import 'package:vms/partials/common/summary_footer_timestamp.dart';

class DetailsSummaryAppointment extends StatefulWidget {
  final bool isSummary;
  final String? visitType;
  final String? appointmentType;
  final int? appointmentStatus;
  final String? appointmentDate;
  final String? startTime;
  final String? endTime;

  DetailsSummaryAppointment({
    Key? key,
    required this.isSummary,
    this.visitType,
    this.appointmentType,
    this.appointmentStatus,
    this.appointmentDate,
    this.startTime,
    this.endTime,
  }) : super(key: key);

  @override
  State<DetailsSummaryAppointment> createState() =>
      _DetailsSummaryAppointmentState();
}

class _DetailsSummaryAppointmentState extends State<DetailsSummaryAppointment> {
  late String visitType;
  late int appointmentStatus;
  late String appointmentType;
  late String appointmentDate;
  late String startTime;
  late String endTime;
  late AppointmentNotifier _appointmentNotifier;
  bool isApproved = false;

  List<Map<String, dynamic>> appointmentStatuses = [];

  @override
  void initState() {
    appointmentStatuses = getAndSetEnumeration(
        context.read<LoginLogoutNotifier>().allEnums, "visitStatusEnum");

    _appointmentNotifier =
        Provider.of<AppointmentNotifier>(context, listen: false);
    visitType =
        widget.visitType ?? _appointmentNotifier.appointments[0].visitType;
    appointmentStatus = widget.appointmentStatus ??
        _appointmentNotifier.appointments[0].appointmentStatus;
    appointmentType = widget.appointmentType ??
        _appointmentNotifier.appointments[0].appointmentType;
    startTime = widget.startTime ??
        CustomDateFormatter.getFormattedTime(
            _appointmentNotifier.appointments[0].startTime);
    endTime = widget.endTime ??
        CustomDateFormatter.getFormattedTime(
            _appointmentNotifier.appointments[0].endTime);
    appointmentDate = widget.appointmentDate ??
        CustomDateFormatter.getFormattedDay(
            _appointmentNotifier.appointments[0].appointmentDate);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    AppointmentNotifier _appointmentNotifier =
        Provider.of<AppointmentNotifier>(context);
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 10,
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Container(
          child: Row(
            children: [
              CustomTextWithBackground(
                text: visitType.toUpperCase(),
                textColor: Palette.CUSTOM_WHITE,
                backgroundColor: Palette.FBN_BLUE,
                fn: () {},
              ),
              SizedBox(
                width: 5,
              ),
              CustomTextWithBackground(
                text: appointmentType.toUpperCase(),
                textColor: Palette.FBN_BLUE,
                backgroundColor: Palette.CUSTOM_YELLOW,
                fn: () {},
              ),
              SizedBox(
                width: 5,
              ),
              CustomTextWithBackground(
                text: selectedAppointmentStatusEnum(
                        appointmentStatus, appointmentStatuses)["name"]
                    .toUpperCase(),
                textColor: Palette.CUSTOM_WHITE,
                backgroundColor: selectedAppointmentStatusEnum(
                                appointmentStatus, appointmentStatuses)["name"]
                            .toLowerCase() ==
                        "approved"
                    ? Palette.FBN_GREEN
                    : Palette.FBN_ORANGE,
                fn: () {},
              ),
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(vertical: 10),
          child: Text(
            appointmentDate,
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
          ),
        ),
        Container(
          child: SummaryFooterTimestamp(
            stampText: CustomDateFormatter.combineTime(startTime, endTime),
          ),
        ),
      ]),
    );
  }
}
