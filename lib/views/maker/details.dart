import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:share_plus/share_plus.dart';
import 'package:vms/custom_classes/palette.dart';
import 'package:vms/custom_widgets/custom_alert_dialog_box.dart';
import 'package:vms/custom_widgets/custom_single_line_button.dart';
import 'package:vms/helperfunctions/appointmentDetailsExtractor.dart';
import 'package:vms/helperfunctions/custom_date_formatter.dart';
import 'package:vms/helperfunctions/enumerationExtraction.dart';
import 'package:vms/helperfunctions/modify_appointment.dart';
import 'package:vms/models/api_response.dart';
import 'package:vms/models/fetched_appointments.dart';
import 'package:vms/notifiers/appointment_notifier.dart';
import 'package:vms/notifiers/login_logout_notifier.dart';
import 'package:vms/notifiers/user_notifier.dart';
import 'package:vms/partials/common/top_swap.dart';
import 'package:vms/services/appointment_service.dart';
import 'package:vms/views/commons/details_appointment.dart';
import 'package:vms/views/commons/details_guests.dart';
import 'package:vms/views/commons/details_location.dart';

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
  APIResponse<FetchedAppointments> fetchedAppointment =
      new APIResponse<FetchedAppointments>(data: null, error: false);
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

    service.getSingleAppointment(context, widget.id).then((data) {
      fetchedAppointment = data;
      print("fetched appointment: ${fetchedAppointment.data}");

      _appointmentNotifier.loadSelectedAppointment(fetchedAppointment.data);
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
          : fetchedAppointment.data == null
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Could not fetch appointment. Please try again",
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pushReplacementNamed(context, '/view');
                        },
                        child: Text(
                          'OK',
                          style: TextStyle(
                            color: Colors.red,
                          ),
                        ),
                      )
                    ],
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
                            visitType: fetchedAppointment.data?.visitType,
                            visitorType:
                                getVisitorType(fetchedAppointment.data),
                            visitStatus: (fetchedAppointment.data?.visitStatus),
                            appointmentDate:
                                CustomDateFormatter.getFormattedDay(
                                    fetchedAppointment.data?.appointmentDate ??
                                        null),
                            startTime: CustomDateFormatter.getFormattedTime(
                                fetchedAppointment.data?.startTime ?? null),
                            endTime: CustomDateFormatter.getFormattedTime(
                                fetchedAppointment.data?.endTime ?? null)),
                        Divider(),
                        DetailsSummaryLocation(
                          floor: fetchedAppointment.data?.floor,
                          location: fetchedAppointment.data?.location,
                          meetingRooms: fetchedAppointment.data?.meetingRooms,
                        ),
                        Divider(),
                        DetailsSummaryGuests(
                          guests: fetchedAppointment.data?.visitors,
                        ),
                        Divider(),
                        widget.isApproved
                            ? Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      Share.share("This is your QR code");
                                    },
                                    icon: Icon(
                                      Icons.share,
                                      color: Palette.FBN_GREEN.withOpacity(0.6),
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      showDialog(
                                          barrierDismissible: true,
                                          barrierColor: Colors.white,
                                          context: context,
                                          builder: (_) {
                                            return AlertDialog(
                                              content: Container(
                                                width: 300,
                                                height: 300,
                                                child: QrImage(
                                                  data:
                                                      'This is a simple QR code',
                                                  version: QrVersions.auto,
                                                  size: 320,
                                                  gapless: false,
                                                ),
                                              ),
                                              actions: <Widget>[
                                                ElevatedButton(
                                                  onPressed: () {
                                                    Navigator.pop(_);
                                                  },
                                                  child: Text("Ok"),
                                                ),
                                              ],
                                            );
                                          });
                                    },
                                    icon: Icon(
                                      Icons.visibility,
                                      color: Palette.FBN_GREEN.withOpacity(0.6),
                                    ),
                                  ),
                                ],
                              )
                            : SizedBox.shrink(),
                      ],
                    ),
                    canModify(
                            fetchedAppointment.data!.endTime,
                            fetchedAppointment.data!.visitStatus
                                    .toLowerCase() ==
                                "cancelled")
                        ? Container(
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
                                      Navigator.pushNamed(context,
                                              '/reschedule_appointment')
                                          .then((value) {
                                        setState(() {});
                                      });
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
