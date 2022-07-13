import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:vms/constants/index.dart';
import 'package:vms/helperfunctions/custom_date_formatter.dart';
import 'package:vms/models/api_response.dart';
import 'package:vms/models/appointment.dart';
import 'package:http/http.dart' as http;
import 'package:vms/models/create_appointment.dart';
import 'package:vms/models/floor.dart';
import 'package:vms/models/group_head.dart';
import 'package:vms/models/host.dart';
import 'package:vms/models/location.dart';
import 'package:vms/models/room.dart';
import 'package:vms/models/visitor.dart';
import 'package:vms/notifiers/login_logout_notifier.dart';

class AppointmentService {
  var url =
      "https://visitmgtsystem.fbn-devops-dev-asenv.appserviceenvironment.net/api/FrontOffice";

  var headers = {
    "Content-Type": "application/json",
  };

  Future<APIResponse<List<Appointment>>> getAppointments(BuildContext context) {
    LoginLogoutNotifier _loginLogoutNotifier =
        Provider.of<LoginLogoutNotifier>(context, listen: false);
    headers["Authorization"] =
        "Bearer ${_loginLogoutNotifier.loggedInUser.token}";

    String staffNo = context.read<LoginLogoutNotifier>().loggedInUser.username;
    print("We got here");
    return http
        .get(Uri.parse("$url/my-appointments/${staffNo}"), headers: headers)
        .then((data) {
      print("status code: ${data.statusCode}");
      if (data.statusCode == 200) {
        final jsonData = json.decode(data.body);
        print("data from get appointments ${jsonData['data'][0]}");
        //convert into list of appointments
        final List<Appointment> appointments = [];
        for (var item in jsonData["data"]) {
          var appointment = Appointment(
            id: item["id"].toString(),
            endTime: CustomDateFormatter.getDateTimeFromTimeString(
                DateTime.parse(item["dateAndTime"]), item["endTime"]),
            startTime: CustomDateFormatter.getDateTimeFromTimeString(
                DateTime.parse(item["dateAndTime"]), item["startTime"]),
            appointmentDate: DateTime.parse(item["dateAndTime"]),
            guests:
                Visitor.convertVisitorMapsToVisitorObjects(item["visitors"]),
            appointmentStatus: item["appointmentStatus"],
            purposeOfReschedule: "", //item["rescheduleReason"].toString(),
            purposeOfCancel: "", //item["cancellationReason"].toString(),
            appointmentType: item["visitType"].toString(),
            meetingRoom: item["meetingRoom"] ?? "",
            //
            host: Host.fromMap(item["host"]),
            groupHead: GroupHead.fromMap(item["groupHead"]),
            visitType: item["visitType"],
            location: Location.fromMap(item["location"]),
            floor: Floor.fromMap(item["floor"]),
            rooms: Room.convertRoomMapsToRoomObjects(item["roomNumbers"]),
          );
          appointments.add(appointment);
        }

        return APIResponse<List<Appointment>>(data: appointments);
      }
      return APIResponse<List<Appointment>>(
          error: true, errorMessage: "Error fetching appointments");
    }).catchError((error) {
      print(error);
      return APIResponse<List<Appointment>>(
          error: true, errorMessage: "Error fetching appointments");
    }).timeout(Duration(milliseconds: DELAY), onTimeout: () {
      return APIResponse<List<Appointment>>(
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
          appointmentType: jsonData["appointmentType"],
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

    CreateAppointment newAppointment =
        CreateAppointment(appointment: appointment);
    print("new appointment: ${newAppointment}");

    var body = json.encode(newAppointment.toJson(),
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
          appointmentType: jsonData["appointmentType"],
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
}
