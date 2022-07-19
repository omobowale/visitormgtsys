import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vms/custom_widgets/custom_drop_down.dart';
import 'package:vms/custom_widgets/custom_error_label.dart';
import 'package:vms/custom_widgets/custom_input_label.dart';
import 'package:vms/helperfunctions/appointmentDetailsExtractor.dart';
import 'package:vms/models/floor.dart';
import 'package:vms/notifiers/appointment_notifier.dart';

class RoomSection extends StatelessWidget {
  final String labelText;
  List<dynamic> roomsList;
  List<dynamic> locationsList;
  RoomSection({
    Key? key,
    required this.labelText,
    required this.roomsList,
    required this.locationsList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomInputLabel(labelText: "Room"),
          CustomErrorLabel(
              errorText: context
                  .read<AppointmentNotifier>()
                  .allLocationErrors["meetingRoom"]),
          CustomDropDown(
            onTap: (value) {
              context.read<AppointmentNotifier>().addMeetingRoom(value);
              String floor = getFloorFromRoomName(locationsList, value);
              dynamic locationDetails =
                  getLocationDetailsFromRoomName(locationsList, value);
              context.read<AppointmentNotifier>().addFloor(floor);
              context
                  .read<AppointmentNotifier>()
                  .addLocationDetails(locationDetails);

              context.read<AppointmentNotifier>().removeError("meetingRoom");
              context.read<AppointmentNotifier>().showAppointment(
                  context.read<AppointmentNotifier>().appointments[0]);
            },
            text: context
                    .watch<AppointmentNotifier>()
                    .appointments[0]
                    .meetingRoom
                    .isEmpty
                ? roomsList[0]
                : context
                    .watch<AppointmentNotifier>()
                    .appointments[0]
                    .meetingRoom,
            lists: roomsList.toSet(),
          ),
        ],
      ),
    );
  }
}
