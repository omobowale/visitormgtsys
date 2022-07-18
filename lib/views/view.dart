import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:vms/custom_classes/palette.dart';
import 'package:vms/custom_widgets/custom_appointment_day_date.dart';
import 'package:vms/custom_widgets/custom_calendar_strip_section.dart';
import 'package:vms/custom_widgets/custom_no_appointment.dart';
import 'package:vms/models/api_response.dart';
import 'package:vms/models/fetched_appointments.dart';
import 'package:vms/notifiers/appointment_notifier.dart';
import 'package:vms/notifiers/user_notifier.dart';
import 'package:vms/services/appointment_service.dart';
import 'package:vms/partials/view/appointment_list.dart';

class View extends StatefulWidget {
  View({Key? key}) : super(key: key);

  @override
  State<View> createState() => _ViewState();
}

class _ViewState extends State<View> {
  AppointmentService get service => GetIt.I<AppointmentService>();
  bool isLoading = false;
  int _selectedIndex = 0;
  DateTime selectedDate = DateTime.now();

  late APIResponse<List<FetchedAppointments>> _appointmentList;
  List<FetchedAppointments> appointmentListData = [];
  List<DateTime> markedDates = [];

  @override
  void initState() {
    UserNotifier _userNotifier =
        Provider.of<UserNotifier>(context, listen: false);

    _appointmentList =
        new APIResponse<List<FetchedAppointments>>(data: [], error: false);

    _fetchAppointmentForDay();
    // TODO: implement initState
    super.initState();
  }

  onSelect(data) {
    if (data != null) {
      setState(() {
        selectedDate = data;
      });
      print("Selected Date -> $data");
      _fetchAppointmentForDay();
    }
  }

  _fetchAppointmentForDay() async {
    _fetchAppointmentsAndUserRole().then((_) {
      setState(() {
        isLoading = false;
      });
      appointmentListData = AppointmentNotifier.fetchAppointmentForDay(
          _appointmentList.data ?? [], selectedDate);
      markedDates =
          AppointmentNotifier.getMarkedDates(_appointmentList.data ?? []);
    });
  }

  _fetchAppointmentsAndUserRole() async {
    setState(() {
      isLoading = true;
    });

    _appointmentList = await service.getAppointments(context);
  }

  @override
  Widget build(BuildContext context) {
    return !isLoading
        ? ListView(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomCalendarStrip(
                    onSelect: onSelect,
                    selectedDate: selectedDate,
                    markedDates: markedDates,
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 18, vertical: 5),
                    child: appointmentListData.length > 0
                        ? Column(
                            children: [
                              AppointmentDayDate(
                                selectedDate: selectedDate,
                              ),
                              AppointmentList(
                                appointmentList: appointmentListData,
                              ),
                            ],
                          )
                        : NoAppointment(
                            selectedDate: selectedDate,
                          ),
                  ),
                ],
              ),
            ],
          )
        : Center(
            child: CircularProgressIndicator(
              color: Palette.FBN_BLUE,
            ),
          );
  }
}
