import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vms/custom_widgets/custom_check_box.dart';
import 'package:vms/custom_widgets/custom_drop_down.dart';
import 'package:vms/custom_widgets/custom_error_label.dart';
import 'package:vms/custom_widgets/custom_input_label.dart';
import 'package:vms/models/room.dart' as r;
import 'package:vms/models/appointment.dart';
import 'package:vms/notifiers/appointment_notifier.dart';
import 'package:vms/notifiers/rooms_notifier.dart';

class RoomsList extends StatelessWidget {
  List<dynamic> roomsList;
  RoomsList({Key? key, required this.roomsList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppointmentNotifier _appointmentNotifier =
        Provider.of<AppointmentNotifier>(context);
    RoomsNotifier _roomsNotifier = Provider.of<RoomsNotifier>(context);

    var usableRoomList =
        _appointmentNotifier.appointments[0].floor.meetingRooms.isEmpty
            ? roomsList
            : _appointmentNotifier.appointments[0].floor.meetingRooms;
    print("list of rooms $usableRoomList");
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomInputLabel(
            labelText: "Choose up to 3 rooms",
          ),
          CustomErrorLabel(
              errorText: context
                  .read<AppointmentNotifier>()
                  .allLocationErrors["rooms"]),
          Container(
            child: Column(
              children: usableRoomList
                  .map(
                    (room) => CustomCheckBox(
                      id: room["id"].toString(),
                      isClicked: (id) {
                        r.Room newRoom = r.Room(
                            name: room["name"],
                            id: room["id"],
                            floorId: context
                                .read<AppointmentNotifier>()
                                .appointments[0]
                                .floor
                                .id);
                        print("A room ${room}");
                        _appointmentNotifier.addRoom(newRoom);
                        context
                            .read<AppointmentNotifier>()
                            .removeError("rooms");
                      },
                      checkList: _appointmentNotifier.appointments[0].rooms,
                      labelText: room["name"].toString(),
                      checked: true,
                      isAvailable: true,
                    ),
                  )
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}
