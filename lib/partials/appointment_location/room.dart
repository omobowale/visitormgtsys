import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vms/custom_widgets/custom_error_label.dart';
import 'package:vms/custom_widgets/custom_input_field.dart';
import 'package:vms/custom_widgets/custom_input_label.dart';
import 'package:vms/notifiers/appointment_notifier.dart';

class Room extends StatefulWidget {
  final Function onComplete;
  const Room({Key? key, required this.onComplete}) : super(key: key);

  @override
  State<Room> createState() => _RoomState();
}

class _RoomState extends State<Room> {
  @override
  Widget build(BuildContext context) {
    String meetingRoom =
        context.watch<AppointmentNotifier>().appointments[0].meetingRoom;
    AppointmentNotifier _appointmentNotifier =
        Provider.of<AppointmentNotifier>(context, listen: true);
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomInputLabel(labelText: "Meeting Room"),
          CustomErrorLabel(
            errorText: _appointmentNotifier.allLocationErrors["meetingRoom"],
          ),
          CustomInputField(
            initialValue: meetingRoom,
            hintText: meetingRoom != null && meetingRoom != ""
                ? meetingRoom
                : "Meeting Room",
            labelText: meetingRoom,
            bordered: false,
            onComplete: (value) async {
              await widget.onComplete(value);
              print("meeting room ==> : " +
                  _appointmentNotifier.appointments[0].meetingRoom);
              if (_appointmentNotifier.appointments[0].meetingRoom != "") {
                _appointmentNotifier.removeError("meetingRoom");
              }
            },
          ),
        ],
      ),
    );
  }
}
