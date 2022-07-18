import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:vms/custom_classes/palette.dart';
import 'package:vms/custom_widgets/custom_alert_dialog_box.dart';
import 'package:vms/custom_widgets/custom_appointment_requests_card.dart';
import 'package:vms/custom_widgets/custom_bottom_navigation_bar.dart';
import 'package:vms/custom_widgets/custom_floating_action_button.dart';
import 'package:vms/data/appointment_statuses.dart';
import 'package:vms/helperfunctions/appointmentDetailsExtractor.dart';
import 'package:vms/helperfunctions/custom_date_formatter.dart';
import 'package:vms/helperfunctions/enumerationExtraction.dart';
import 'package:vms/helperfunctions/modify_appointment.dart';
import 'package:vms/models/api_response.dart';
import 'package:vms/models/appointment.dart';
import 'package:vms/models/appointment_request.dart';
import 'package:vms/models/fetched_appointments.dart';
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
  late Future<APIResponse<List<FetchedAppointments>>> _appointmentList2;

  List<AppointmentRequest> appointmentRequests = [];
  AppointmentService get service => GetIt.I<AppointmentService>();

  late bool isGH;
  bool isGHLoading = false;
  bool isLoading = false;
  bool showApproveDeny = false;
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
    _appointmentList2 = (GHId != "" && GHId != null)
        ? service.getAppointmentRequests(context)
        : service.getAppointments(context);
    showApproveDeny = (GHId != "" && GHId != null) ? true : false;
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
                FutureBuilder<APIResponse<List<FetchedAppointments>>>(
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
                              APIResponse<List<FetchedAppointments>> data =
                                  snapshot.data!;
                              print("fetched data: ${data.data!}");
                              List<FetchedAppointments> requestsData =
                                  getGHRequests(data.data!, GHId, isGH);

                              return requestsData.isNotEmpty
                                  ? Column(
                                      children: requestsData
                                          .map((appointmentRequest) {
                                        return AppointmentRequestsCard(
                                            showApproveDeny: showApproveDeny,
                                            floor: appointmentRequest.floor,
                                            meetingRooms:
                                                appointmentRequest.meetingRooms,
                                            location:
                                                appointmentRequest.location,
                                            guests: appointmentRequest.visitors,
                                            groupHead:
                                                appointmentRequest.groupHead,
                                            appointmentId: appointmentRequest
                                                .appointmentId,
                                            startTime:
                                                appointmentRequest.startTime,
                                            endTime: appointmentRequest.endTime,
                                            visitPurpose:
                                                appointmentRequest.visitPurpose,
                                            visitorType: getVisitorType(
                                                appointmentRequest),
                                            date: appointmentRequest
                                                .appointmentDate,
                                            address:
                                                appointmentRequest.location,
                                            staffImagePath:
                                                "assets/images/image_placeholder.jpg",
                                            host: appointmentRequest.host,
                                            noOfGuests: appointmentRequest
                                                .visitors.length,
                                            cancelReason: appointmentRequest
                                                .cancellationReason,
                                            visitStatus:
                                                appointmentRequest.visitStatus);
                                      }).toList(),
                                    )
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

  List<FetchedAppointments> getGHRequests(
      List<FetchedAppointments> list, String ghId, bool isGH) {
    if (!isGH) {
      return list;
    }
    try {
      return list.where((element) {
        return element.visitStatus.toLowerCase() != "approved" &&
            element.visitStatus.toLowerCase() != "cancelled" &&
            ghId == element.groupHead.id.toString();
      }).toList();
    } on StateError {
      return [];
    }
  }
}
