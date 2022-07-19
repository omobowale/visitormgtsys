import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:vms/custom_widgets/custom_appointment_day_date.dart';
import 'package:vms/custom_widgets/custom_appointment_list_item.dart';
import 'package:vms/data/appointment_statuses.dart';
import 'package:vms/helperfunctions/appointmentDetailsExtractor.dart';
import 'package:vms/helperfunctions/custom_date_formatter.dart';
import 'package:vms/helperfunctions/custom_string_manipulations.dart';
import 'package:vms/helperfunctions/enumerationExtraction.dart';
import 'package:vms/models/api_response.dart';
import 'package:vms/models/appointment.dart';
import 'package:vms/models/fetched_appointments.dart';
import 'package:vms/notifiers/appointment_notifier.dart';
import 'package:vms/notifiers/login_logout_notifier.dart';
import 'package:vms/services/appointment_service.dart';

class AppointmentList extends StatefulWidget {
  List<FetchedAppointments> appointmentList;

  AppointmentList({Key? key, required this.appointmentList}) : super(key: key);

  @override
  State<AppointmentList> createState() => _AppointmentListState();
}

class _AppointmentListState extends State<AppointmentList> {
  bool isApproved = false;
  List<Map<String, dynamic>> appointmentStatuses = [];

  @override
  void initState() {
    // TODO: implement initState
    LoginLogoutNotifier _loginLogoutNotifier =
        Provider.of<LoginLogoutNotifier>(context, listen: false);
    appointmentStatuses = getAndSetEnumeration(
        _loginLogoutNotifier.allEnums, "appointmentStatusEnum");
  }

  bool getIsApproved(
      int appointmentStatus, List<Map<String, dynamic>> statuses) {
    var x = selectedAppointmentStatusEnum(appointmentStatus, statuses);
    if (x.isNotEmpty) {
      if (x["name"].toLowerCase() == "approved") {
        return true;
      }

      return false;
    }

    return false;
  }

  bool getIsCancelled(
      int appointmentStatus, List<Map<String, dynamic>> statuses) {
    var x = selectedAppointmentStatusEnum(appointmentStatus, statuses);
    if (x.isNotEmpty) {
      if (x["name"].toLowerCase() == "cancelled") {
        return true;
      }

      return false;
    }

    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(children: [
        ...widget.appointmentList.map((fetchedAppointment) {
          return AppointmentListItem(
            appointmentId: fetchedAppointment.appointmentId.toString(),
            isApproved: fetchedAppointment.isApproved,
            isCancelled:
                fetchedAppointment.visitStatus.toLowerCase() == "cancelled"
                    ? true
                    : false,
            startTime: CustomDateFormatter.getFormattedTime(
                fetchedAppointment.startTime),
            endTime: CustomDateFormatter.getFormattedTime(
                fetchedAppointment.endTime),
            appointmentType: fetchedAppointment.visitType,
            visitorName: fetchedAppointment.visitors.length > 1
                ? fetchedAppointment.visitors.toList().length.toString() +
                    " visitors"
                : fetchedAppointment.visitors.length == 0
                    ? ""
                    : CustomStringManipulation.getFullName(
                        fetchedAppointment.visitors[0].firstName,
                        fetchedAppointment.visitors[0].lastName),
            isGroupVisit: fetchedAppointment.visitors.length > 1 ? true : false,
          );
        }).toList()
      ]),
    );
  }
}
