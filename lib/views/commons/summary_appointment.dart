import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vms/custom_classes/palette.dart';
import 'package:vms/custom_widgets/custom_text_with_background.dart';
import 'package:vms/data/appointment_statuses.dart';
import 'package:vms/helperfunctions/appointmentDetailsExtractor.dart';
import 'package:vms/helperfunctions/custom_date_formatter.dart';
import 'package:vms/helperfunctions/enumerationExtraction.dart';
import 'package:vms/notifiers/appointment_notifier.dart';
import 'package:vms/notifiers/login_logout_notifier.dart';
import 'package:vms/partials/common/summary_footer_timestamp.dart';

class SummaryAppointment extends StatefulWidget {
  final bool isSummary;
  final String? visitType;
  final String? visitorType;
  final int? appointmentStatus;
  final String? appointmentDate;
  final String? visitPurpose;
  final String? startTime;
  final String? endTime;

  SummaryAppointment({
    Key? key,
    required this.isSummary,
    this.visitType,
    this.visitorType,
    this.appointmentStatus,
    this.visitPurpose,
    this.appointmentDate,
    this.startTime,
    this.endTime,
  }) : super(key: key);

  @override
  State<SummaryAppointment> createState() => _SummaryAppointmentState();
}

class _SummaryAppointmentState extends State<SummaryAppointment> {
  late String visitType;
  late int appointmentStatus;
  late String visitorType;
  late String visitPurpose;
  late String appointmentDate;
  late String startTime;
  late String endTime;
  late AppointmentNotifier _appointmentNotifier;
  bool isApproved = false;

  List<Map<String, dynamic>> appointmentStatuses = [];

  @override
  void initState() {
    appointmentStatuses = getAndSetEnumeration(
        context.read<LoginLogoutNotifier>().allEnums, "appointmentStatusEnum");
    print("appointment statuses: ${appointmentStatuses}");
    print("enum by name: ${getEnumByName(appointmentStatuses, "Active")}");

    _appointmentNotifier =
        Provider.of<AppointmentNotifier>(context, listen: false);
    visitType =
        widget.visitType ?? _appointmentNotifier.appointments[0].visitType;
    visitPurpose = widget.visitPurpose ??
        _appointmentNotifier.appointments[0].visitPurpose;
    visitorType =
        widget.visitorType ?? _appointmentNotifier.appointments[0].visitorType;
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
                text: visitPurpose.toUpperCase(),
                textColor: Palette.CUSTOM_WHITE,
                backgroundColor: Palette.FBN_BLUE,
                fn: () {},
              ),
              SizedBox(
                width: 5,
              ),
              CustomTextWithBackground(
                text: visitorType.toUpperCase(),
                textColor: Palette.FBN_BLUE,
                backgroundColor: Palette.CUSTOM_YELLOW,
                fn: () {},
              ),
              SizedBox(
                width: 5,
              ),
              CustomTextWithBackground(
                text: "Pending".toUpperCase(),
                textColor: Palette.CUSTOM_WHITE,
                backgroundColor: Palette.FBN_ORANGE,
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
