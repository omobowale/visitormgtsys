import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:vms/constants/index.dart';
import 'package:vms/helperfunctions/custom_date_formatter.dart';
import 'package:vms/models/api_response.dart';
import 'package:vms/models/appointment.dart';
import 'package:http/http.dart' as http;
import 'package:vms/models/approve_appointment.dart';
import 'package:vms/models/cancel_appointment.dart';
import 'package:vms/models/create_appointment.dart';
import 'package:vms/models/fetched_appointments.dart';
import 'package:vms/models/floor.dart';
import 'package:vms/models/group_head.dart';
import 'package:vms/models/host.dart';
import 'package:vms/models/location.dart';
import 'package:vms/models/reschedule_appointment.dart';
import 'package:vms/models/room.dart';
import 'package:vms/models/visitor.dart';
import 'package:vms/notifiers/login_logout_notifier.dart';

class AppointmentService {
  var url =
      "https://visitmgtsystem.fbn-devops-dev-asenv.appserviceenvironment.net/api/FrontOffice";

  var headers = {
    "Content-Type": "application/json",
  };

  Future<APIResponse<List<FetchedAppointments>>> getAppointments(
      BuildContext context) {
    LoginLogoutNotifier _loginLogoutNotifier =
        Provider.of<LoginLogoutNotifier>(context, listen: false);
    print("Token: ${_loginLogoutNotifier.loggedInUser.token}");
    headers["Authorization"] =
        "Bearer ${_loginLogoutNotifier.loggedInUser.token}";

    String staffNo = context.read<LoginLogoutNotifier>().loggedInUser.username;
    print("We got here");
    return http
        .get(Uri.parse("$url/my-appointments/${staffNo}"), headers: headers)
        .then((data) {
      print("status code: ${data.statusCode}");
      if (data.body.isNotEmpty) {
        final jsonData = json.decode(data.body);
        // print("jsondata ooo: $jsonData");
        //convert into list of appointments
        if (jsonData["data"].length > 0) {
          final List<FetchedAppointments> fetchedAppointments = [];
          for (var item in jsonData["data"]) {
            print(
                "startTime: ${CustomDateFormatter.getFormattedTime(DateTime.parse(item["endTime"]))}");
            var fAppointment = FetchedAppointments(
              appointmentId: item["id"],
              endTime: CustomDateFormatter.getDateTimeFromTimeString(
                  DateTime.parse(item["dateAndTime"]),
                  CustomDateFormatter.getFormattedTime(
                      DateTime.parse(item["endTime"]))),
              startTime: CustomDateFormatter.getDateTimeFromTimeString(
                  DateTime.parse(item["dateAndTime"]),
                  CustomDateFormatter.getFormattedTime(
                      DateTime.parse(item["startTime"]))),
              appointmentDate: DateTime.parse(item["dateAndTime"]),
              visitors:
                  Visitor.convertVisitorMapsToVisitorObjects(item["visitors"]),
              appointmentStatus: item["appointmentStatus"],
              rescheduleReason: item["rescheduleReason"].toString(),
              cancellationReason: item["cancellationReason"].toString(),
              visitGuid: item["visitGuid"].toString(),
              meetingRooms: item["meetingRooms"] ?? "",
              host: Host.emptyOne(), // Host.fromMap(item["host"]),
              groupHead: GroupHead.fromMap(item["groupHead"]),
              visitType: item["visitType"],
              location: item["location"],
              floor: item["floor"],
              visitPurpose: item["visitPurpose"],
              visitStatus: item["visitStatus"],
              isApproved: item["isApproved"],
              isCancelled: item["isCancelled"],
            );
            fetchedAppointments.add(fAppointment);
          }

          return APIResponse<List<FetchedAppointments>>(
              data: fetchedAppointments);
        } else {
          return APIResponse<List<FetchedAppointments>>(data: []);
        }
      }
      return APIResponse<List<FetchedAppointments>>(
          error: true, errorMessage: "Error fetching appointments");
    }).catchError((error) {
      print(error);
      return APIResponse<List<FetchedAppointments>>(
          error: true, errorMessage: "Error fetching appointments");
    }).timeout(Duration(milliseconds: DELAY), onTimeout: () {
      return APIResponse<List<FetchedAppointments>>(
        data: [],
        error: true,
        errorMessage: "Request timed out. Please try again",
      );
    });
  }

  Future<APIResponse<FetchedAppointments>> getSingleAppointment(
      BuildContext context, String visitId) {
    LoginLogoutNotifier _loginLogoutNotifier =
        Provider.of<LoginLogoutNotifier>(context, listen: false);
    print("Token: ${_loginLogoutNotifier.loggedInUser.token}");
    headers["Authorization"] =
        "Bearer ${_loginLogoutNotifier.loggedInUser.token}";

    String staffNo = context.read<LoginLogoutNotifier>().loggedInUser.username;
    print("We got here");
    print("visit id: ${visitId}");
    return http
        .get(Uri.parse("$url/get-appointment-by-visit-id/${visitId}"),
            headers: headers)
        .then((data) {
      print("status code: ${data.statusCode}");
      if (data.body.isNotEmpty) {
        final jsonData = json.decode(data.body);
        final extractedData = jsonData['data'];

        var fAppointment = FetchedAppointments(
          appointmentId: extractedData["id"],
          endTime: CustomDateFormatter.getDateTimeFromTimeString(
              DateTime.parse(extractedData["dateAndTime"]),
              CustomDateFormatter.getFormattedTime(
                  DateTime.parse(extractedData["endTime"]))),
          startTime: CustomDateFormatter.getDateTimeFromTimeString(
              DateTime.parse(extractedData["dateAndTime"]),
              CustomDateFormatter.getFormattedTime(
                  DateTime.parse(extractedData["startTime"]))),
          appointmentDate: DateTime.parse(extractedData["dateAndTime"]),
          visitors: Visitor.convertVisitorMapsToVisitorObjects(
              extractedData["visitors"]),
          appointmentStatus: extractedData["appointmentStatus"],
          rescheduleReason: extractedData["rescheduleReason"].toString(),
          cancellationReason: extractedData["cancellationReason"].toString(),
          visitGuid: "",
          meetingRooms: extractedData["meetingRooms"] ?? "",
          host: Host.fromMap(extractedData["host"]),
          groupHead: GroupHead.fromMap(extractedData["groupHead"]),
          visitType: extractedData["visitType"],
          location: extractedData["location"],
          floor: extractedData["floor"],
          visitPurpose: extractedData["visitPurpose"],
          visitStatus: extractedData["visitStatus"],
          isApproved: extractedData["isApproved"],
          isCancelled: extractedData["isCancelled"],
        );

        return APIResponse<FetchedAppointments>(data: fAppointment);
      }
      return APIResponse<FetchedAppointments>(
          error: true, errorMessage: "Error fetching single appointment");
    }).catchError((error) {
      print("There was an error fetching single appointment");
      print(error);
      return APIResponse<FetchedAppointments>(
          error: true, errorMessage: "Error fetching single appointment");
    }).timeout(Duration(milliseconds: DELAY), onTimeout: () {
      return APIResponse<FetchedAppointments>(
        error: true,
        errorMessage: "Request timed out. Please try again",
      );
    });
  }

  Future<APIResponse<List<FetchedAppointments>>> getAppointmentRequests(
      BuildContext context) {
    LoginLogoutNotifier _loginLogoutNotifier =
        Provider.of<LoginLogoutNotifier>(context, listen: false);
    print("Token: ${_loginLogoutNotifier.loggedInUser.token}");
    headers["Authorization"] =
        "Bearer ${_loginLogoutNotifier.loggedInUser.token}";

    print("We got here for group head appointment requests");
    return http
        .get(Uri.parse("$url/grouphead-appointments"), headers: headers)
        .then((data) {
      print("status code: ${data.statusCode}");
      if (data.body.isNotEmpty) {
        final jsonData = json.decode(data.body);
        print("jsondata: $jsonData");
        //convert into list of appointments
        if (jsonData["data"].length > 0) {
          final List<FetchedAppointments> fetchedAppointments = [];
          for (var item in jsonData["data"]) {
            var fAppointment = FetchedAppointments(
                appointmentId: item["id"],
                endTime: CustomDateFormatter.getDateTimeFromTimeString(
                    DateTime.parse(item["dateAndTime"]),
                    CustomDateFormatter.getFormattedTime(
                        DateTime.parse(item["endTime"]))),
                startTime: CustomDateFormatter.getDateTimeFromTimeString(
                    DateTime.parse(item["dateAndTime"]),
                    CustomDateFormatter.getFormattedTime(
                        DateTime.parse(item["startTime"]))),
                appointmentDate: DateTime.parse(item["dateAndTime"]),
                visitors: Visitor.convertVisitorMapsToVisitorObjects(
                    item["visitors"]),
                appointmentStatus: item["appointmentStatus"],
                rescheduleReason: item["rescheduleReason"].toString(),
                cancellationReason: item["cancellationReason"].toString(),
                visitGuid: item["visitGuid"].toString(),
                meetingRooms: item["meetingRooms"] ?? "",
                host: Host.fromMap(item["host"]),
                groupHead: GroupHead.fromMap(item["groupHead"]),
                visitType: item["visitType"],
                location: item["location"],
                floor: item["floor"],
                visitPurpose: item["visitPurpose"],
                visitStatus: item["visitStatus"],
                isApproved: item["isApproved"],
                isCancelled: item["isCancelled"]);
            fetchedAppointments.add(fAppointment);
          }

          return APIResponse<List<FetchedAppointments>>(
              data: fetchedAppointments);
        } else {
          return APIResponse<List<FetchedAppointments>>(data: []);
        }
      }
      return APIResponse<List<FetchedAppointments>>(
          error: true, errorMessage: "Error fetching appointments");
    }).catchError((error) {
      print(error);
      return APIResponse<List<FetchedAppointments>>(
          error: true, errorMessage: "Error fetching appointments");
    }).timeout(Duration(milliseconds: DELAY), onTimeout: () {
      return APIResponse<List<FetchedAppointments>>(
        data: [],
        error: true,
        errorMessage: "Request timed out. Please try again",
      );
    });
  }

  Future<APIResponse<Appointment>> getAppointment(appointmentId) {
    return http.get(Uri.parse("$url/appointments/$appointmentId")).then((data) {
      if (data.statusCode == 200) {
        final jsonData = json.decode(data.body);

        var appointment = Appointment(
          id: jsonData["id"],
          guests:
              Visitor.convertVisitorMapsToVisitorObjects(jsonData["guests"]),
          groupHead: GroupHead.fromMap(jsonData["groupHead"]),
          purposeOfReschedule: jsonData["purposeOfReschedule"],
          purposeOfCancel: jsonData["purposeOfCancel"],
          visitorType:
              Visitor.convertVisitorMapsToVisitorObjects(jsonData["guests"])[0]
                  .visitorType,
          appointmentStatus: jsonData["appointmentStatus"],
          visitType: jsonData["visitType"],
          endTime: DateTime.parse(jsonData["endTime"]),
          startTime: DateTime.parse(jsonData["startTime"]),
          location: Location.fromMap(jsonData["location"]),
          floor: Floor.fromMap(jsonData["floor"]),
          meetingRoom: jsonData["meetingRoom"],
          rooms: Room.convertRoomMapsToRoomObjects(jsonData["roomNumbers"]),
          host: Host.fromMap(jsonData["host"]),
          appointmentDate: DateTime.parse(jsonData["appointmentDate"]),
          visitPurpose: jsonData["visitPurpose"],
        );

        return APIResponse<Appointment>(data: appointment, error: false);
      }
      return APIResponse<Appointment>(
          error: true, errorMessage: "Error fetching appointment");
    }).catchError((error) {
      print("error here: " + error.toString());
      return APIResponse<Appointment>(
          error: true, errorMessage: "Error fetching appointment");
    });
  }

  Future<APIResponse<Appointment>> createAppointment(
      Appointment appointment, BuildContext context) {
    LoginLogoutNotifier _loginLogoutNotifier =
        Provider.of<LoginLogoutNotifier>(context, listen: false);
    headers["Authorization"] =
        "Bearer ${_loginLogoutNotifier.loggedInUser.token}";

    print("Token: ${_loginLogoutNotifier.loggedInUser.token}");

    CreateAppointment newAppointment =
        CreateAppointment(appointment: appointment);
    print("new appointment: ${newAppointment}");

    var body = json.encode(newAppointment.toJson(context),
        toEncodable: newAppointment.myEncode);

    print("new appointment json: ${body}");

    return http
        .post(
      Uri.parse("$url/schedule-appointment"),
      headers: headers,
      body: body,
    )
        .then((data) {
      print("data ${data.body}");
      var result = json.decode(data.body);
      if (data.statusCode == 200) {
        return APIResponse<Appointment>(
            data: appointment, error: false, errorMessage: "");
      }
      return APIResponse<Appointment>(
          error: true, errorMessage: result["message"], data: null);
    }).catchError((error) {
      print("Error here: ${error}");
      return APIResponse<Appointment>(
          error: true,
          errorMessage: "Could not create appointment",
          data: null);
    });
  }

  Future<APIResponse<Appointment>> updateAppointment(
      Appointment appointment, String appointmentId) {
    return http
        .put(Uri.parse("$url/appointments/$appointmentId"),
            headers: headers,
            body: json.encode(appointment.toJson(),
                toEncodable: appointment.myEncode))
        .then((data) {
      if (data.statusCode == 200) {
        final jsonData = json.decode(data.body);
        var appointment = Appointment(
          id: jsonData["id"],
          guests:
              Visitor.convertVisitorMapsToVisitorObjects(jsonData["guests"]),
          groupHead: GroupHead.fromMap(jsonData["groupHead"]),
          purposeOfReschedule: jsonData["purposeOfReschedule"],
          purposeOfCancel: jsonData["purposeOfCancel"],
          visitorType:
              Visitor.convertVisitorMapsToVisitorObjects(jsonData["guests"])[0]
                  .visitorType,
          appointmentStatus: jsonData["appointmentStatus"],
          visitType: jsonData["visitType"],
          endTime: DateTime.parse(jsonData["endTime"]),
          startTime: DateTime.parse(jsonData["startTime"]),
          location: Location.fromMap(jsonData["location"]),
          floor: Floor.fromMap(jsonData["floor"]),
          meetingRoom: jsonData["meetingRoom"],
          rooms: Room.convertRoomMapsToRoomObjects(jsonData["roomNumbers"]),
          host: Host.fromMap(jsonData["host"]),
          appointmentDate: DateTime.parse(jsonData["appointmentDate"]),
          visitPurpose: jsonData["visitPurpose"],
        );

        return APIResponse<Appointment>(data: appointment, error: null);
      }

      return APIResponse<Appointment>(
          error: true, errorMessage: "Error fetching appointment");
    }).catchError((error) {
      print("error here update: " + error.toString());
      return APIResponse<Appointment>(
          error: true, errorMessage: "Error fetching appointment");
    });
  }

  Future<APIResponse<bool>> approveAppointment(
      ApproveAppointment approveDetails, BuildContext context) {
    LoginLogoutNotifier _loginLogoutNotifier =
        Provider.of<LoginLogoutNotifier>(context, listen: false);
    headers["Authorization"] =
        "Bearer ${_loginLogoutNotifier.loggedInUser.token}";
    print("visitId : ${approveDetails.visitId}");
    return http
        .post(
            Uri.parse(
                "$url/approve-appointment?visitId=${approveDetails.visitId}"),
            headers: headers)
        .then((data) {
      print("data.statusCode ${data.body}");
      if (data.statusCode == 200) {
        return APIResponse<bool>(data: true, error: null);
      }

      return APIResponse<bool>(
          error: true, errorMessage: "Error approving appointment");
    }).catchError((error) {
      print("error here update: " + error.toString());
      return APIResponse<bool>(
          error: true, errorMessage: "Error approving appointment");
    });
  }

  Future<APIResponse<bool>> cancelAppointment(
      CancelAppointment cancelDetails, BuildContext context) {
    LoginLogoutNotifier _loginLogoutNotifier =
        Provider.of<LoginLogoutNotifier>(context, listen: false);
    headers["Authorization"] =
        "Bearer ${_loginLogoutNotifier.loggedInUser.token}";
    print("headers: ${headers}");
    return http
        .post(
      Uri.parse(
          "$url/cancel-appointment/${cancelDetails.visitId}/${cancelDetails.reason}"),
      headers: headers,
    )
        .then((data) {
      print("data status code: ${data.body}");
      if (data.statusCode == 200) {
        return APIResponse<bool>(data: true, error: null);
      }

      return APIResponse<bool>(
          error: true, errorMessage: "Error cancelling appointment");
    }).catchError((error) {
      print("error here cancel: " + error.toString());
      return APIResponse<bool>(
          error: true, errorMessage: "Error cancelling appointment");
    });
  }

  Future<APIResponse<bool>> rescheduleAppointment(
      RescheduleAppointment rescheduleDetails) {
    return http
        .post(Uri.parse("$url/reschedule-appointment"),
            headers: headers,
            body: json.encode(rescheduleDetails.toJson(),
                toEncodable: rescheduleDetails.myEncode))
        .then((data) {
      print("data.statusCode ${data.body}");
      if (data.statusCode == 200) {
        return APIResponse<bool>(data: true, error: null);
      }

      return APIResponse<bool>(
          error: true, errorMessage: "Error rescheduling appointment");
    }).catchError((error) {
      print("error here reschedule: " + error.toString());
      return APIResponse<bool>(
          error: true, errorMessage: "Error rescheduling appointment");
    });
  }
}
