import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:vms/custom_classes/palette.dart';
import 'package:vms/custom_widgets/custom_alert_dialog_box.dart';
import 'package:vms/custom_widgets/custom_appointment_requests_card.dart';
import 'package:vms/custom_widgets/custom_bottom_navigation_bar.dart';
import 'package:vms/custom_widgets/custom_floating_action_button.dart';
import 'package:vms/data/appointment_statuses.dart';
import 'package:vms/helperfunctions/appointmentStatusExtractor.dart';
import 'package:vms/helperfunctions/custom_date_formatter.dart';
import 'package:vms/helperfunctions/enumerationExtraction.dart';
import 'package:vms/helperfunctions/modify_appointment.dart';
import 'package:vms/models/api_response.dart';
import 'package:vms/models/appointment.dart';
import 'package:vms/models/appointment_request.dart';
import 'package:vms/notifiers/appointment_notifier.dart';
import 'package:vms/notifiers/login_logout_notifier.dart';
import 'package:vms/notifiers/user_notifier.dart';
import 'package:vms/partials/appointment_requests/page_title.dart';
import 'package:vms/partials/appointment_requests/staff_details.dart';
import 'package:vms/services/appointment_service.dart';

class AppointmentRequests extends StatefulWidget {
  const AppointmentRequests({Key? key}) : super(key: key);

  @override
  State<AppointmentRequests> createState() => _AppointmentRequestsState();
}

class _AppointmentRequestsState extends State<AppointmentRequests> {
  late Future<APIResponse<List<Appointment>>> _appointmentList2;

  List<AppointmentRequest> appointmentRequests = [];
  AppointmentService get service => GetIt.I<AppointmentService>();

  late bool isGH;
  bool isGHLoading = false;
  bool isLoading = false;
  int noOfRequests = 0;
  late String GHId;

  List<Map<String, dynamic>> statuses = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    UserNotifier _userNotifier =
        Provider.of<UserNotifier>(context, listen: false);

    LoginLogoutNotifier _loginLogoutNotifier =
        Provider.of<LoginLogoutNotifier>(context, listen: false);

    setState(() {
      isGHLoading = true;
    });

    GHId = _userNotifier.getGHId();
    _appointmentList2 = service.getAppointments(context);
    statuses = getAndSetEnumeration(
        _loginLogoutNotifier.allEnums, "appointmentStatusEnum");

    isGH = _userNotifier.isUserGH;
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Scaffold(
            body: Center(
              child: CircularProgressIndicator(
                color: Palette.FBN_BLUE,
              ),
            ),
          )
        : Scaffold(
            body: ListView(
              children: [
                PageTitle(),
                Divider(),
                FutureBuilder<APIResponse<List<Appointment>>>(
                  future: _appointmentList2,
                  builder: (context, snapshot) {
                    switch (snapshot.connectionState) {
                      case ConnectionState.waiting:
                        return Center(
                          child: Text(
                            "Please wait...",
                          ),
                        );
                      case ConnectionState.done:
                      default:
                        if (snapshot.hasData) {
                          if (snapshot.data != null) {
                            if (snapshot.data!.data != null) {
                              APIResponse<List<Appointment>> data =
                                  snapshot.data!;
                              List<Appointment> requestsData =
                                  getGHRequests(data.data!, GHId);

                              return requestsData.isNotEmpty
                                  ? Column(
                                      children: requestsData
                                          .map((appointmentRequest) {
                                      if (canModify(appointmentRequest) &&
                                          canBeApproved(
                                              appointmentRequest
                                                  .appointmentStatus,
                                              statuses)) {
                                        return AppointmentRequestsCard(
                                          floor: appointmentRequest.floor,
                                          meetingRoom:
                                              appointmentRequest.meetingRoom,
                                          location: appointmentRequest.location,
                                          guests: appointmentRequest.guests,
                                          groupHead:
                                              appointmentRequest.groupHead,
                                          appointmentId: appointmentRequest.id,
                                          startTime:
                                              appointmentRequest.startTime,
                                          endTime: appointmentRequest.endTime,
                                          officialityText:
                                              appointmentRequest.visitType,
                                          appointmentTypeText:
                                              appointmentRequest
                                                  .appointmentType,
                                          date: appointmentRequest
                                              .appointmentDate,
                                          address:
                                              appointmentRequest.location.name,
                                          staffImagePath:
                                              "assets/images/image_placeholder.jpg",
                                          host: appointmentRequest.host,
                                          noOfGuests:
                                              appointmentRequest.guests.length,
                                        );
                                      } else {
                                        return Container();
                                      }
                                    }).toList())
                                  : Center(
                                      child: Text(
                                        "No appointment requests",
                                      ),
                                    );
                            } else {
                              Future.delayed(
                                Duration.zero,
                                () => showDialog(
                                  barrierDismissible: false,
                                  context: context,
                                  builder: (BuildContext context) {
                                    return CustomAlertDialogBox(
                                      textTitle: "Error",
                                      redirectLocation: '/view',
                                      textContent:
                                          "Oops! Could not fetch appointment requests.\nPlease try again later!",
                                      color: Colors.red,
                                      function: () {},
                                    );
                                  },
                                ),
                              );
                            }
                          }
                        } else if (snapshot.hasError) {
                          return Text(
                            "Error fetching requests. Please try again later",
                          );
                        }
                    }

                    return Container();
                  },
                ),
              ],
            ),
            // : SizedBox(
            //     height: double.infinity,
            //     child: Center(
            //       child: Text(
            //         "No appointment requests",
            //         style: TextStyle(
            //           fontWeight: FontWeight.w500,
            //           fontSize: 16,
            //         ),
            //       ),
            //     ),
            //   ),
            bottomNavigationBar: CustomBottomNavigationBar(
              isGH: isGH,
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.endDocked,
            floatingActionButton: CustomFloatingActionButton(),
          );
  }

  List<Appointment> getGHRequests(List<Appointment> list, String ghId) {
    try {
      return list.where((element) {
        return element.appointmentStatus == PENDING &&
            ghId == element.groupHead.id;
      }).toList();
    } on StateError {
      return [];
    }
  }
}
